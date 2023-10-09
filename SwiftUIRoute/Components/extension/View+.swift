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
    
    func ndunderline(_ topPadding: CGFloat = 0) -> some View {
        VStack(spacing: topPadding) {
            self
            Divider()
                .foregroundColor(.l1)
        }
    }
    
    func ndsize(_ size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
    
    func ndenabled(_ enabled: Bool) -> some View {
        modifier(NDEnabledViewModifier(enabled: enabled))
    }
    
    func ndbuttonstyle(
        _ size: NDButtonSize = .large,
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
    
    func ndbuttonstyleclear() -> some View {
        buttonStyle(NDButtonClearStyle())
    }
    
    @ViewBuilder
    func ndshimmer(show: Bool = true) -> some View {
        if show {
            modifier(ShimmerModifier(configuration: ShimmerConfiguration(
                gradient: Gradient(stops: [
                    .init(color: .black, location: 0),
                    .init(color: .white, location: 0.3),
                    .init(color: .white, location: 0.7),
                    .init(color: .black, location: 1),
                ]),
                initialLocation: (start: UnitPoint(x: -1, y: 0.5), end: .leading),
                finalLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
                duration: 1,
                opacity: 0.3
            )))
        } else {
            self
        }
    }
}

//MARK: - Debug
extension View {
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif
        return self
    }
    
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
