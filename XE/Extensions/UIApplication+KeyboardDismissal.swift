//
//  UIApplication+KeyboardDismissal.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import UIKit

// Extension on `UIApplication` to add functionality for dismissing the keyboard
extension UIApplication {
    
    // Dismisses the keyboard for the current view
    func dismissKeyboard() {
        // Safely unwraps the first connected window scene
        guard let windowScene = connectedScenes.first as? UIWindowScene else { return }
        
        // Dismisses keyboard by ending editing in the first window
        windowScene.windows.first?.endEditing(true)
    }
}
