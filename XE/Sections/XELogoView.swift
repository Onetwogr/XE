//
//  XELogoView.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//

import SwiftUI

// View for displaying the XE logo with dynamic styling based on screen size and theme
struct XELogoView: View {
    
    let geometry: GeometryProxy // Provides screen size
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var fadeIn: Bool // Controls fade-in animation

    var body: some View {
        VStack {
            // Welcome text with dynamic font size
            Text("Welcome to")
                .bold()
                .font(Font.custom("Delycost", size: geometry.size.width > geometry.size.height ? 25 : 30))
                .foregroundColor(colorScheme == .light ? .black : .white)
            
            // XE branding text with dynamic size and animation
            Text("xe")
                .font(.system(size: geometry.size.width > geometry.size.height ? 60 : 80, weight: .heavy, design: .rounded))
                .foregroundColor(Color("XEColor"))
                .offset(y: fadeIn ? 0 : -30) // Applies animation offset
        }
    }
}

struct XELogoView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            XELogoView(geometry: geometry, fadeIn: .constant(true))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}

