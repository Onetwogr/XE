//
//  XEButton.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// A customizable button with configurable title, action, and styling options
struct XEButton: View {
    
    @Environment(\.colorScheme) var colorScheme // Detect light/dark mode

    var title: String = ""
    var image: Image? = nil
    var action: () -> Void // Action when button is tapped
    var isDisabled: Bool = false
    var font: Font = Font.custom("Avenir Next", size: 25).bold()
    var frame: CGSize

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                // Display image if available
                if let img = image {
                    img
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .background(Color.clear)
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }

                if !title.isEmpty {
                    Text(title)
                        .font(font)
                        .foregroundColor(isDisabled ? .gray : (colorScheme == .light ? .white : .black))
                }
            }
            .frame(width: frame.width, height: frame.height)
            .background(isDisabled ? Color.gray.opacity(0.3) : (image != nil ? Color.gray.opacity(0.3) : Color("XEColor")))
            .cornerRadius(title.isEmpty ? frame.width / 2 : 10)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    XEButton(
        title: "XE Button",
        action: {
            print("Button clicked!")
        },
        frame: CGSize(width: 300, height: 60)
    )
    .padding()
}
