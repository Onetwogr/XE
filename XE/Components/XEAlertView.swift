//
//  XEAlertView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// A custom ViewModifier to display an alert with an optional cancel button
struct XEAlertView: ViewModifier {
    
    let title: String
    let message: String
    let onDismiss: () -> Void
    var hasCancelButton: Bool = false
    
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
        // Modifies the view to display an alert when isPresented is true
        .alert(isPresented: $isPresented) {
            if hasCancelButton {
                // Alert with OK and Cancel buttons
                return Alert(
                    title: Text(title), // Title of the alert
                    message: Text(message), // Message displayed in the alert
                    primaryButton: .default(Text("OK")) {
                        // Dismiss the alert and execute the onDismiss action
                        isPresented = false
                        onDismiss()
                    },
                    secondaryButton: .cancel {
                        // Dismiss the alert without executing any action
                        isPresented = false
                    }
                )
            } else {
                // Alert with only an OK button
                return Alert(
                    title: Text(title), // Title of the alert
                    message: Text(message), // Message displayed in the alert
                    dismissButton: .default(Text("OK")) {
                        // Dismiss the alert and execute the onDismiss action
                        isPresented = false
                        onDismiss()
                    }
                )
            }
        }
    }
}
