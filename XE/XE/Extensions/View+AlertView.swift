//
//  View+AlertView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// Extension on `View` to add a custom alert view modifier
extension View {
    func alertView(title: String, message: String, isPresented: Binding<Bool>, onDismiss: @escaping () -> Void, hasCancelButton: Bool = false) -> some View {
        self.modifier(XEAlertView(title: title, message: message, onDismiss: onDismiss, hasCancelButton: hasCancelButton, isPresented: isPresented))
    }
}
