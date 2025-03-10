//
//  LocationModel.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import Foundation

// Model representing a location with placeId, mainText, and secondaryText
struct Location: Decodable {
    let placeId: String // Unique identifier for the location
    let mainText: String // Primary text (e.g., name of the location)
    let secondaryText: String // Secondary text (e.g., address or description)
}
