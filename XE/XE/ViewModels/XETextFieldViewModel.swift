//
//  XETextFieldViewModel.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI
import Foundation

// ViewModel for handling text field input and location search
class XETextFieldViewModel: ObservableObject {
    
    @Published var cachedResults: [String: [Location]] = [:] // Cache to store previously fetched results by query prefix
    @Published var locations: [Location] = [] // List of locations based on user input
    @Published var isLoading: Bool = false // Tracks API call status
    @Published var showResults: Bool = false // Controls result visibility
    @Published var errorMessage: String? = nil // Stores any error messages
    @Published var showAlert = false // Flag to control showing error alerts
    
    private let endpoint: String // API endpoint for fetching locations
    
    // Initializer for setting the endpoint
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    // Fetch data and update the locations state based on the user's query
    func fetchData(query: String) {
        
        // Ensure the query has at least 3 characters before proceeding
        guard query.count >= 3 else {
            locations = [] // Clear results when query is less than 3 characters
            showResults = false
            return
        }

        // Use the first 3 characters of the query as a cache key
        let cacheKey = query.prefix(3).lowercased()
        
        // Fetch data either from API or local cache based on query length
        if query.count == 3 {
            fetchFromAPI(query: query, cacheKey: cacheKey)
        } else {
            searchLocally(query: query, cacheKey: cacheKey)
        }
    }

    // Fetch data from the API and update the locations list
    private func fetchFromAPI(query: String, cacheKey: String) {
        
        // Check if we have cached data for the query
        if let cachedLocations = cachedResults[cacheKey] {
            // Filter cached locations based on the query
            self.locations = cachedLocations.filter { $0.mainText.lowercased().contains(query.lowercased()) }
            self.showResults = !self.locations.isEmpty
        } else {
            isLoading = true // Set loading state while fetching data from the API
            let queryParams = ["input": query] // Query parameters for the API request
            
            // Make network request to fetch locations
            NetworkManager.shared.fetchData(
                endpoint: endpoint,
                queryParameters: queryParams,
                responseType: [Location].self
            ) { result in
                DispatchQueue.main.async {
                    self.isLoading = false // Reset loading state after request completes
                    switch result {
                    case .success(let fetchedLocations):
                        // Cache the fetched results
                        self.cachedResults[cacheKey] = fetchedLocations
                        self.locations = fetchedLocations
                        self.showResults = !fetchedLocations.isEmpty // Show results if available
                        self.errorMessage = nil // Reset error message if request is successful
                    case .failure(let error):
                        self.showResults = false // Hide results if there's an error
                        self.handleError(error) // Handle error if the request fails
                    }
                }
            }
        }
    }

    // Search locally in the cached data if available
    private func searchLocally(query: String, cacheKey: String) {
        // Filter cached locations based on the query
        if let cachedLocations = cachedResults[cacheKey] {
            self.locations = cachedLocations.filter { $0.mainText.lowercased().contains(query.lowercased()) }
            self.showResults = !self.locations.isEmpty
        }
    }

    // Handle API errors and update the error message state
    private func handleError(_ error: NetworkError) {
        self.errorMessage = ErrorHandler.showErrorMessage(for: error) // Retrieve error message from the error handler
        self.showAlert = true // Trigger alert to show error message
    }

    // Validate the selection made by the user and return the query if valid
    func validateSelection(query: String) -> String {
        // Check if the selected query matches any cached location
        if !locations.contains(where: { $0.mainText.lowercased() == query.lowercased() }) {
            return "" // Clear field if input doesn't match any cached result
        }
        return query // Return the query if validation passes
    }
    
    func validateAndSetSelection(query: String) -> String {
        return locations.contains(where: { $0.mainText.lowercased() == query.lowercased() }) ? query : ""
    }
    
}
