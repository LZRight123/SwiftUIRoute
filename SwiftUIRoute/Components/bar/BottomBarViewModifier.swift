//
//  BottomBarViewModifier.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

extension View {
    func ndbottomBar(@ViewBuilder content: () -> some View)  -> some View {
        modifier(BottomBarViewModifier(contentView: content))
    }
}

private struct BottomBarViewModifier<ContentView: View>: ViewModifier {
    @ViewBuilder let contentView: ContentView

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    bottomBar
                }
        } else {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
                bottomBar
            }
        }
    }
    
    var bottomBar: some View {
        NDBottomBar { contentView }

    }
    
}
