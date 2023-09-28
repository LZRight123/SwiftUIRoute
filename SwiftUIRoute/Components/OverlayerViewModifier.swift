//
//  LoadingModifier.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwiftUI

extension View {
    func ndoverlayer(_ isShow: Bool, @ViewBuilder content: () -> some View) -> some View {
        modifier(OverlayerViewModifier(isShowOverlayer: isShow, contentView: content))
    }
}

private struct OverlayerViewModifier<ContentView: View>: ViewModifier {
    let isShowOverlayer: Bool
    
    @ViewBuilder let contentView: ContentView
    
    func body(content: Content) -> some View {
        if isShowOverlayer {
            content.overlay(contentView)
        } else {
            content
        }
    }
    
}
