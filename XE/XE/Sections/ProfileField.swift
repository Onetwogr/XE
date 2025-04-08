//
//  ProfileField.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

struct ProfileField: View {
    
    let title: String
    @Binding var value: String
    let isEditing: Bool // Flag to determine if the field is in editing mode

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).foregroundColor(.primary)
            if isEditing {
                // Display a TextField if editing is enabled
                TextField("Enter \(title.lowercased())", text: $value)
                    .font(.body)
                    .padding(.vertical, 4)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
            } else {
                // Display the value as static text if not in editing mode
                Text(value).font(.body).foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    ProfileField(
        title: "Name",
        value: .constant("John Doe"),
        isEditing: true
    )
}
