//
//  Button+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

enum NDButtonSize {
    case small(minWidth: CGFloat = 60) // 4个字的长度
    case large
}

//MARK: - 自定义 buttonStyle
struct NDButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let contentColor: Color
    let isLoading: Bool
    let size: NDButtonSize
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        ZStack {
            if isLoading {
                ProgressView()
                    .scaleEffect()
                    .progressViewStyle(CircularProgressViewStyle(tint: contentColor))
            } else {
                configuration.label
            }
        }
        .modifier(NDButtonSizeViewModifier(size: size))
        .foregroundColor(contentColor)
        .background(backgroundColor)
        .clipShape(Capsule())
        .compositingGroup()
        .shadow(radius:isPressed ? 0 : 5,x:0,y: isPressed ? 0 :3)
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.spring(), value: isPressed)
    }
}

private struct NDButtonSizeViewModifier: ViewModifier {
    let size: NDButtonSize
    func body(content: Content) -> some View {
        switch size {
        case let .small(minWidth):
            content
                .frame(minWidth: minWidth)
                .padding(.horizontal, NDPadding.content)
                .padding(.vertical, NDPadding.smallButtonVPadding)
        case .large:
            content.padding(.vertical, NDPadding.largeButtonVPadding)
                .frame(maxWidth: .infinity)
        }
    }
}
