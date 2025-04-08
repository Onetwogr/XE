//
//  XEDropDownView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

struct DropdownView: View {
    
    // ResultItem struct to represent each dropdown item
    struct ResultItem: Identifiable {
        var id = UUID() // Unique identifier for each item
        var text: String
    }
    
    @Binding var text: String
    @Binding var showResults: Bool // Controls dropdown visibility
    @Binding var isSelected: Bool // Tracks if an item is selected
    @Binding var lastSelectedText: String
    var results: [ResultItem] // List of dropdown items
    
    var body: some View {
        // Show dropdown if conditions are met
        if showResults && text.count >= 3 {
            ScrollView {
                // Iterate through results and display them
                ForEach(results) { result in
                    
                    Text(result.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .horizontal])
                        .cornerRadius(8)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isSelected = true
                            lastSelectedText = result.text
                            withAnimation {
                                text = result.text
                                showResults = false // Hide dropdown after selection
                            }
                        }
                    Divider()
                        .padding(.horizontal)
                }
            }
            .background(Color.gray.opacity(0.5))
            .frame(maxHeight: 200)
            .cornerRadius(8)
            .shadow(radius: 5)
            .padding(.top, 5)
        }
    }
}

#Preview {
    DropdownView(
        text: .constant(""),
        showResults: .constant(false),
        isSelected: .constant(false),
        lastSelectedText: .constant("Result 1"),
        results: [
            DropdownView.ResultItem(text: "Result 1"),
            DropdownView.ResultItem(text: "Result 2"),
            DropdownView.ResultItem(text: "Result 3")
        ]
    )
}
