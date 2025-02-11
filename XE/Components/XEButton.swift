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
    
    var title: String
    var action: () -> Void
    var isDisabled: Bool = false
    var font: Font = Font.custom("Avenir Next", size: 25).bold()

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(isDisabled ? .gray : (colorScheme == .light ? .white : .black))
                .padding()
                .frame(width: 300, height: 60)
                .background(isDisabled ? Color.gray.opacity(0.3) : Color("XEColor"))
                .cornerRadius(10)
        }
        .disabled(isDisabled)
        .padding(.bottom, 10)
    }
    
}

struct XEButton_Previews: PreviewProvider {
    static var previews: some View {
        XEButton(title: "XE Button", action: {
            print("Button clicked!")
        })
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
