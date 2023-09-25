//
//  ScrollViewContentOffset.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/7.
//

import SwiftUI

struct ScrollViewContentOffset: View {
    @State var postion: CGPoint = .zero
    var body: some View {
        VStack {
            Text("\(postion.y)")
            OffsetObservingScrollView(offset: $postion) {
                ForEach(1..<100) { _ in
                    Text("123")
                }
            }
        }
        
    }
}

struct ScrollViewContentOffset_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewContentOffset()
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    
    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}


struct PositionObservingView<Content: View>: View  {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: PreferenceKey.self,
                        value: geometry.frame(in: coordinateSpace).origin
                    )
                }
            )
            .onPreferenceChange(PreferenceKey.self) { position  in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}
