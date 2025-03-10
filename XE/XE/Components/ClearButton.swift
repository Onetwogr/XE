//
//  ClearButton.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// A button that triggers a clear action with a confirmation alert
struct ClearButton: View {

    var action: () -> Void // Clear Action

    @State private var showAlert = false

    var body: some View {
        Button(action: {
            // Show confirmation alert when the button is pressed
            showAlert = true
        }) {
            Text("Clear")
                .foregroundColor(.red)
                .bold()
        }
        // Displays the custom alert view
        .alertView(
            title: "Are you sure?",
            message: "This action cannot be undone.",
            isPresented: $showAlert,
            onDismiss: {
                action()
            },
            hasCancelButton: true // Display a cancel button to allow the user to dismiss the alert
        )
    }
}

#Preview {
    ClearButton(action: { print("Clear button pressed") })
}
