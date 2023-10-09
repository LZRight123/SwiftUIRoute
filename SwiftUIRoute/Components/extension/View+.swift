//
//  View+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ndoverlayer(_ isShow: Bool, @ViewBuilder content: () -> some View) -> some View {
        if isShow {
            overlay(content())
        } else {
            self 
        }
    }
    
    func ndunderline(topPadding: CGFloat = 0) -> some View {
        VStack(spacing: topPadding) {
            self
            Divider()
                .foregroundColor(.l1)
        }
    }
    
    func ndenabled(enabled: Bool) -> some View {
        modifier(NDEnabledViewModifier(enabled: enabled))
    }
    
    func ndbuttonstyle(
        size: NDButtonSize = .large,
        isLoading: Bool = false,
        backgroundColor: Color = .black,
        contentColor: Color = .white
    ) -> some View {
        buttonStyle(
            NDButtonStyle(
                backgroundColor: backgroundColor,
                contentColor: contentColor,
                isLoading: isLoading,
                size: size
            )
        )
    }
}

//MARK: - Debug
extension View {
    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func debugBorder(_ color: Color = .red, width: CGFloat = 2) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }
    
    func debugBackground(_ color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }
}
