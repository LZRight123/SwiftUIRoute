//
//  NDNavBar.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwiftUI

struct NDNavBar<Content: View>: View {
    let backgroudColor: Color
    @ViewBuilder let leading: (any View)?
    @ViewBuilder let trailing: (any View)?
    @ViewBuilder let content: Content
    
    init(
        backgroudColor: Color = .b2.opacity(0.9),
        leading: (() -> any View)? = nil,
        trailing: (() -> any View)? = nil,
        content: () -> Content
    ) {
        self.backgroudColor = backgroudColor
        self.leading = leading?()
        self.trailing = trailing?()
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Group {
                //leading trailing
                HStack(
                    spacing: 0,
                    content: {
                        if let leading = leading {
                            AnyView(leading)
                        }
                        Spacer()
                        if let trailing = trailing {
                            AnyView(trailing)
                        }
                    }
                )
                .padding(.horizontal, 12)
                
                // titleView
                HStack(spacing: 0, content: {
                    content
                })
            }
            .frame(height: 44)
        }
        .frame(minHeight: 0.1)
        .frame(maxWidth: .infinity)
        .background(BarBackgorundView(color: backgroudColor))
    }
}

struct NDNavBar_Previews: PreviewProvider {
    static var previews: some View {
        NDNavBar(
            content: {
                Text("标题呀")
            }
        )
    }
}
