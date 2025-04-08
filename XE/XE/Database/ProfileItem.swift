//
//  ProfileItem.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import Foundation
import SwiftData

// Model representing a profile item
@Model
final class ProfileItem {
    
    var id: UUID = UUID() // Unique identifier for the profile item
    var name: String?
    var yearOfBirth: String?
    var gender: String?
    var profileImageData: Data?
    var timestamp: Date = Date() // Timestamp for when the profile item was created or modified

    // Initializer to create a ProfileItem object with optional properties
    init(name: String? = nil, yearOfBirth: String? = nil, gender: String? = nil,
         profileImageData: Data? = nil) {
        self.name = name
        self.yearOfBirth = yearOfBirth
        self.gender = gender
        self.profileImageData = profileImageData
    }
}
