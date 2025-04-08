//
//  ProfilePicker.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

struct ProfilePicker: View {
    
    @Binding var selection: String
    
    let title: String
    let options: [String] // The list of options for the picker
    let isEditing: Bool // Flag to determine if the picker is in editing mode

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).foregroundColor(.primary)
            if isEditing {
                // Display a Picker if editing is enabled
                Picker(title, selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            } else {
                // Display the selected option as static text if not in editing mode
                Text(selection).font(.body).foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    ProfilePicker(
        selection: .constant("Option 1"),
        title: "Select Option",
        options: ["Option 1", "Option 2", "Option 3"],
        isEditing: true
    )
}
