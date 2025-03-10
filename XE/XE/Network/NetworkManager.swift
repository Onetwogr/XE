//
//  NetworkManager.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import Foundation

// Network manager responsible for handling API requests and responses
class NetworkManager {
    
    // Singleton instance of the NetworkManager
    static let shared = NetworkManager()

    // Fetches data from the given endpoint
    func fetchData<T: Decodable>(
        endpoint: String,
        queryParameters: [String: String] = [:],
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // Constructs the URL with the base URL and endpoint
        var urlComponents = URLComponents(string: "\(APIConfig.baseURL)\(endpoint)")
        urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        // Safely unwraps the URL
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }

        // Creates a data task to fetch data from the server
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handles any network error
            if let error = error {
                let networkError = self.mapNetworkError(from: error)
                completion(.failure(networkError))
                return
            }

            // Ensures data is received
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // Handles HTTP status codes
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                self.handleStatusCode(statusCode, data: data, completion: completion)
            } else {
                completion(.failure(.unknown))
            }
        }

        task.resume() // Starts the network request
    }

    // Handles the response status code and decodes the data if successful
    private func handleStatusCode<T: Decodable>(_ statusCode: Int, data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) {
        switch statusCode {
        case 200...299:
            // Decodes the data into the expected response type
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        case 400:
            completion(.failure(.invalidRequest))
        case 401:
            completion(.failure(.unauthorized))
        case 403:
            completion(.failure(.forbidden))
        case 404:
            completion(.failure(.notFound))
        case 500:
            completion(.failure(.serverError(statusCode: statusCode)))
        default:
            completion(.failure(.unknown))
        }
    }

    // Maps a native network error to a `NetworkError`
    private func mapNetworkError(from error: Error) -> NetworkError {
        let nsError = error as NSError
        switch nsError.code {
        case NSURLErrorNotConnectedToInternet:
            return .noConnection
        case NSURLErrorTimedOut:
            return .timeout
        default:
            return .unknown
        }
    }
}
