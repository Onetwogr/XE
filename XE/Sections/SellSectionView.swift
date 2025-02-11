//
//  SellSectionView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// View for displaying the form section to sell a property
struct SellSectionView: View {
    
    @Binding var title: String // Property title
    @Binding var location: String // Property location
    @Binding var price: String // Property price
    @Binding var description: String // Property description
    @Binding var isLocationSelected: Bool // Bind the isSelected flag

    var body: some View {
        VStack(spacing: 5) {
            
            // Title Field
            XETextField(
                title: "Title*",
                placeholder: "Type a title",
                keyboardType: .default,
                text: $title,
                isSelected: $isLocationSelected
            )
            
            // Location Field with autocomplete functionality
            XETextField(
                title: "Location*",
                placeholder: "Type a location",
                keyboardType: .default,
                text: $location,
                endpoint: APIEndpoints.autocomplete,
                isSelected: $isLocationSelected
            )
            
            // Price Field
            XETextField(
                title: "Price",
                placeholder: "Type a price",
                keyboardType: .numberPad,
                text: $price,
                isSelected: $isLocationSelected
            )
            
            // Description Editor
            XETextEditor(
                placeholder: "Add description",
                text: $description
            )
        }
    }
}

struct SellSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SellSectionView(
            title: .constant("Home"), // Use .constant to provide a binding
            location: .constant("Litohoro"),
            price: .constant("100000"),
            description: .constant("Test string"),
            isLocationSelected: .constant(false)
        )
    }
}

