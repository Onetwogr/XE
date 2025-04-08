//
//  XEFooterView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// View for displaying the footer with creator's name, dynamically styled based on screen size and theme
struct XEFooterView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let geometry: GeometryProxy // Provides screen size

    var body: some View {
        HStack {
            Text("Created by ")
                .font(Font.custom("Avenir Next", size: geometry.size.width > geometry.size.height ? 14 : 16))
                .foregroundColor(colorScheme == .light ? .black : .white)

            Link("Ioannis Gkortsos", destination: URL(string: "https://www.linkedin.com/in/onetwogr")!)
                .bold()
                .font(Font.custom("Avenir Next", size: geometry.size.width > geometry.size.height ? 14 : 16))
                .foregroundColor(Color("XEColor"))
        }
    }
}

#Preview {
    GeometryReader { geometry in
        XEFooterView(geometry: geometry)
            .padding()
    }
}
