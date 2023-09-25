//
//  SwiftUIAndModifier.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/7.
//

import SwiftUI

struct SwiftUIAndModifier: View {
    var body: some View {
        VStack {
            // View-based version:
            FeaturedLabel {
                Text("Hello, world!")
            }
            // Modifier-based version:
            Text("Hello, world!").featured()
        }
    }
}

struct SwiftUIAndModifier_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAndModifier()
    }
}


struct FeaturedLabel<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack {
            Image(systemName: "star")
            content()
        }
        .foregroundColor(.orange)
        .font(.headline)
    }
}

extension View {
    func featured() -> some View {
        HStack {
            Image(systemName: "star")
            self
        }
        .foregroundColor(.orange)
        .font(.headline)
    }
}
