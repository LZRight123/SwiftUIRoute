//
//  NDEnabledViewModifier.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

/// 失活状态下 盖一层背景
struct NDEnabledViewModifier: ViewModifier {
    let enabled: Bool
    func body(content: Content) -> some View {
        if enabled {
            content
        } else {
            content
                .overlay(
                    Color.white.clipShape(Capsule())
                        .blur(radius: 0.3)
                        .opacity(0.3)
                        .onTapGesture {}
                )
        }
    }
}
