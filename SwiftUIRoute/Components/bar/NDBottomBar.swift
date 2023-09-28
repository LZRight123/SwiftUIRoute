//
//  NDBottomBar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwiftUI

struct NDBottomBar<Content: View>: View {
    let backgroudColor: Color
    @ViewBuilder let content: Content
    
    init(
        backgroudColor: Color = .b2.opacity(0.9),
        content: () -> Content
    ) {
        self.backgroudColor = backgroudColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
        }
        .frame(maxWidth: .infinity)
        .background(BarBackgorundView(color: backgroudColor))
    }
}

struct NDBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        NDBottomBar {
            Text("bottom bar")
        }
    }
}
