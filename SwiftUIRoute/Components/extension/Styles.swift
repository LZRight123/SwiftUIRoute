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

// MARK: - shimmer
public class ShimmerConfiguration {
    var gradient: Gradient
    var initialLocation: (start: UnitPoint, end: UnitPoint)
    var finalLocation: (start: UnitPoint, end: UnitPoint)
    var duration: TimeInterval
    var opacity: Double
    init(gradient: Gradient, initialLocation: (start: UnitPoint, end: UnitPoint), finalLocation: (start: UnitPoint, end: UnitPoint), duration: TimeInterval, opacity: Double) {
        self.gradient = gradient
        self.initialLocation = initialLocation
        self.finalLocation = finalLocation
        self.duration = duration
        self.opacity = opacity
    }
}

public struct ShimmerModifier: ViewModifier {
    let configuration: ShimmerConfiguration
    public func body(content: Content) -> some View {
        ShimmeringView(configuration: configuration) { content }
    }
}

struct ShimmeringView<Content: View>: View {
    private let content: () -> Content
    private let configuration: ShimmerConfiguration
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    init(configuration: ShimmerConfiguration, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        _startPoint = .init(wrappedValue: configuration.initialLocation.start)
        _endPoint = .init(wrappedValue: configuration.initialLocation.end)
    }

    var body: some View {
        content()
            .overlay(
                LinearGradient(
                    gradient: configuration.gradient,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                .rotationEffect(.degrees(10))
                .opacity(configuration.opacity)
                .blendMode(.screen)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                            startPoint = configuration.finalLocation.start
                            endPoint = configuration.finalLocation.end
                        }
                    }
                })
            )
    }
}
