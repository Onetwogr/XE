//
//  XETextEditor.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// A custom text editor with a placeholder that disappears when the user types
struct XETextEditor: View {
    
    var placeholder: String
    
    @Binding var text: String
    
    @State private var isPlaceholderVisible: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title for the text editor section
            Text("Description")
                .font(.headline)
                .foregroundColor(.gray)
            
            ZStack(alignment: .topLeading) {
        
                //Hide/Show Placeholder
                if isPlaceholderVisible {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                // Text editor where the user types the description
                TextEditor(text: $text)
                    .frame(height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .opacity(text.isEmpty ? 0.6 : 1)
                    .onChange(of: text) { _, newValue in
                        isPlaceholderVisible = newValue.isEmpty
                    }
            }
        }
        .padding(.horizontal)
    }
}

struct XETextEditor_Previews: PreviewProvider {
    static var previews: some View {
        XETextEditor(placeholder: "Enter description here", text: .constant("Test"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
