//
//  WelcomeView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI
import SwiftData

// Enum representing the available user actions.
enum ActionType {
    case buy, sell
}

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    @Query private var profiles: [ProfileItem] // Fetch profiles from the model
    @Environment(\.modelContext) private var modelContext // Access to model context for saving data

    @Environment(\.colorScheme) var colorScheme // Detects system color scheme (light/dark mode)
    @State private var navigateToPropertyAction = false // Flag to navigate to property action view
    @State private var actionType: ActionType = .sell // Default action type
    @State private var fadeIn = false // Controls fade-in animation
    
    @State private var profileUIImage: UIImage? = nil
    @State private var isProfileViewActive = false // Flag to toggle the profile view

    var body: some View {
        
        NavigationStack {
            
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
                            navigateToPropertyAction = true
                        },
                        frame: CGSize(width: 300, height: 60)
                    )

                    // Buy Property Button (---Disabled for now---)
                    XEButton(
                        title: "Buy Property",
                        action: {
                            // Placeholder for future implementation
                            // actionType = .buy
                            // showPropertyActionView = true
                        },
                        isDisabled: true,
                        frame: CGSize(width: 300, height: 60)
                    )
                    
                    Spacer()
                    
                    // Footer view
                    XEFooterView(geometry: geometry)
                }
                .onAppear {
                    // Fade-in animation
                    fadeIn = true
                    viewModel.ensureProfileExists(modelContext: modelContext, profiles: profiles) // Call from the ViewModel
                    viewModel.loadProfileImage(profiles: profiles) // Load profile image in ViewModel
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(fadeIn ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: fadeIn)
                .navigationDestination(isPresented: $navigateToPropertyAction) {
                    PropertyActionView(actionType: actionType)
                }
                .navigationDestination(isPresented: $isProfileViewActive) {
                    ProfileView()
                }
                .navigationBarItems(
                    leading:
                        XEButton(
                            image: viewModel.profileUIImage != nil ? Image(uiImage: viewModel.profileUIImage!) : Image(systemName: "person.circle.fill"),
                            action: { isProfileViewActive.toggle() },
                            frame: CGSize(width: 40, height: 40)
                        )
                )
            }
        }
        .tint(Color("XEColor"))
    }
}

#Preview {
    WelcomeView()
}
