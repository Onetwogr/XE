//
//  ErrorHandler.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import Foundation

// A class responsible for handling and displaying network-related errors
class ErrorHandler {

    // Handles different types of network errors and logs them
    // - Parameter error: The `NetworkError` to be handled
    static func handleNetworkError(_ error: NetworkError) {
        switch error {
        case .noConnection:
            print("No internet connection.")
        case .timeout:
            print("Request timed out.")
        case .invalidURL:
            print("The URL provided is invalid.")
        case .noData:
            print("No data received from the server.")
        case .decodingError(let decodingError):
            print("Failed to decode response: \(decodingError.localizedDescription)")
        case .serverError(let statusCode):
            print("Server error with status code: \(statusCode).")
        case .unauthorized:
            print("Unauthorized request. Please log in.")
        case .rateLimited:
            print("Rate limit exceeded. Try again later.")
        case .unknown:
            print("An unknown error occurred.")
        case .forbidden:
            print("Forbidden access. You do not have permission to access this resource.")
        case .notFound:
            print("Resource not found. Please check the URL or try again later.")
        case .invalidRequest:
            print("Invalid request. Please check the request format or data.")
        case .serviceUnavailable:
            print("Service is temporarily unavailable. Please try again later.")
        }
    }

    // Returns a user-friendly error message for displaying in the UI
    // - Parameter error: The `NetworkError` to get a message for
    // - Returns: A string with the appropriate error message
    static func showErrorMessage(for error: NetworkError) -> String {
        switch error {
        case .noConnection:
            return "Please check your internet connection."
        case .timeout:
            return "The request timed out. Please try again."
        case .invalidURL:
            return "The URL seems to be incorrect."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "There was an issue processing the data."
        case .serverError(let statusCode):
            return "Server error: \(statusCode). Please try again later."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .rateLimited:
            return "You’ve hit the rate limit. Please try again later."
        case .unknown:
            return "An unknown error occurred. Please try again."
        case .forbidden:
            return "You do not have permission to access this resource."
        case .notFound:
            return "The resource could not be found. Please check the URL."
        case .invalidRequest:
            return "The request was invalid. Please check the data or format."
        case .serviceUnavailable:
            return "The service is temporarily unavailable. Please try again later."
        }
    }
}
