//
//  WelcomeView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// Enum representing the available user actions.
enum ActionType {
    case buy, sell
}

struct WelcomeView: View {

    @Environment(\.colorScheme) var colorScheme // Detects system color scheme (light/dark mode)
    
    @State private var showPropertyActionView = false // Controls the presentation of PropertyActionView
    @State private var actionType: ActionType = .sell // Default action type
    @State private var fadeIn = false // Controls fade-in animation

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                // App logo
                XELogoView(geometry: geometry, fadeIn: $fadeIn)
                
                // Sell Property Button
                XEButton(
                    title: "Sell Property",
                    action: {
                        actionType = .sell
                        showPropertyActionView = true
                    }
                )
                
                // Buy Property Button (---Disabled for now---)
                XEButton(
                    title: "Buy Property",
                    action: {
                        // Placeholder for future implementation
                        // actionType = .buy
                        // showPropertyActionView = true
                    },
                    isDisabled: true
                )
                
                Spacer()
                
                // Footer view
                XEFooterView(geometry: geometry)
            }
            .onAppear {
                // Fade-in animation
                fadeIn = true
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(fadeIn ? 1 : 0)
            .animation(.easeInOut(duration: 1), value: fadeIn)
            .sheet(isPresented: $showPropertyActionView) {
                PropertyActionView(actionType: actionType)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
