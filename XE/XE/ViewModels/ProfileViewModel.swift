//
//  ProfileViewModel.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//


import PhotosUI
import SwiftData

@Observable
class ProfileViewModel {
    
    var name = ""
    var selectedYearOfBirth = "1990"
    var selectedGender = "Prefer not to say"
    var profileUIImage: UIImage? = nil
    var isEditing = false // Flag to track if the profile is in editing mode

    let genders = ["Male", "Female", "Prefer not to say"]
    let yearsOfBirth = Array(1900...2025).map { String($0) }

    // Method to load a profile's data into the view model
    func load(from profile: ProfileItem?) {
        guard let profile else { return }
        name = profile.name ?? ""
        selectedYearOfBirth = profile.yearOfBirth ?? "1990"
        selectedGender = profile.gender ?? "Prefer not to say"
        if let data = profile.profileImageData {
            profileUIImage = UIImage(data: data)
        }
    }

    // Method to save the current profile data to the context
    func save(to context: ModelContext, existingProfile: ProfileItem?) {
        let imageData = profileUIImage?.jpegData(compressionQuality: 0.8)
        if let profile = existingProfile {
            // Update an existing profile
            profile.name = name
            profile.yearOfBirth = selectedYearOfBirth
            profile.gender = selectedGender
            profile.profileImageData = imageData
        } else {
            // Create a new profile and insert it into the context
            let newProfile = ProfileItem(name: name, yearOfBirth: selectedYearOfBirth, gender: selectedGender, profileImageData: imageData)
            context.insert(newProfile)
        }
    }
}

