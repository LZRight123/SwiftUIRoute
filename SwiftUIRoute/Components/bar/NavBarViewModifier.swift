//
//  NavBarViewModifier.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

//MARK: - 导航栏
extension View {
    func ndnavbar(
        @ViewBuilder content: () -> some View,
        @ViewBuilder leading: () -> some View = {
            Text("返回")
                .onTapGesture {
                    RouteStore.shared.pop()
                }
        },
        @ViewBuilder trailing: () -> some View
    ) -> some View {
        modifier(NavBarViewModifier(title: content, leading: leading, trailing: trailing))
    }
    
    
}

private struct NavBarViewModifier<Title: View,Leading: View, Trailing: View>: ViewModifier {
    @ViewBuilder let title: Title
    @ViewBuilder let leading: Leading
    @ViewBuilder let trailing: Trailing
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .safeAreaInset(edge: .top, spacing: 0) {
                    navbar
                }
        } else {
            VStack(spacing: 0) {
                navbar
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
            }
        }
    }
    
    var navbar: some View {
        ZStack {
            Group {
                //leading trailing
                HStack(spacing: 0, content: {
                    leading
                    Spacer()
                    trailing
                })
                .padding(.horizontal, 16)
                
                // titleView
                HStack(spacing: 0, content: {
                    self.title
                })
            }
            .frame(height: 44)
        }
        .frame(minHeight: 0.1)
        .frame(maxWidth: .infinity)
        .background(BarBackgorundView())
    }
}
