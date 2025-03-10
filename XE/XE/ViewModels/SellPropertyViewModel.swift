//
//  SellPropertyViewModel.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

class SellPropertyViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
    @Published var isLocationSelected: Bool = false // Tracks if location is selected

    @Published var submittedAd: String = "" // JSON output of submitted ad
    @Published var showAlert: Bool = false // Controls JSON alert visibility
    
    
    // Form Validation
    var isFormValid: Bool {
        !title.isEmpty && isLocationSelected
    }

    // Submits the form by converting input into JSON format and clearing fields
    func submitForm() {
        let ad = [
            "title": title,
            "location": location,
            "price": price,
            "description": description
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: ad, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            submittedAd = jsonString
            showAlert = true
        }

        clearForm()
    }

    // Clears all form fields
    func clearForm() {
        title = ""
        location = ""
        price = ""
        description = ""
        isLocationSelected = false // Reset the selected flag
    }
}
