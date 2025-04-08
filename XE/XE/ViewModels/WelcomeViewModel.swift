//
//  WelcomeViewModel.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI
import SwiftData

class WelcomeViewModel: ObservableObject {
    
    @Published var profileUIImage: UIImage? = nil // The profile image
    @Published var navigateToPropertyAction = false // Flag to navigate to property action screen
    @Published var actionType: ActionType = .sell // The action type, default is sell
    
    // Method to ensure a profile exists in the model context
    func ensureProfileExists(modelContext: ModelContext, profiles: [ProfileItem]) {
        if profiles.isEmpty {
            let newProfile = ProfileItem()
            do {
                modelContext.insert(newProfile)
                try modelContext.save()
                print("New profile created and saved.")
            } catch {
                print("Failed to create profile: \(error)")
            }
        } else {
            print("Profile already exists.")
        }
    }

    // Method to load the profile image from saved profile data
    func loadProfileImage(profiles: [ProfileItem]) {
        guard let savedProfile = profiles.first,
              let data = savedProfile.profileImageData,
              let image = UIImage(data: data) else { return }
        profileUIImage = image
    }
}


