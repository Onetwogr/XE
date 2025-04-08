//
//  ActionSectionView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// View for displaying the action section with a submit button and mandatory fields note
struct ActionSectionView: View {
    
    var title: String
    var isFormValid: Bool // Flag indicating if the form is valid
    var submitForm: () -> Void // Closure to handle form submission

    var body: some View {
        VStack {
            // Note indicating mandatory fields
            Text("Fields marked with * are mandatory.")
                .font(.footnote)
                .foregroundColor(.gray)

            // Submit Button
            XEButton(
                title: title,
                action: submitForm,
                isDisabled: !isFormValid,
                frame: CGSize(width: 300, height: 60)
            )
        }
    }
}

#Preview {
    // Preview for the ActionSectionView with sample data
    ActionSectionView(title: "Submit", isFormValid: true, submitForm: {
        print("Submit Button Pressed")
    })
}
