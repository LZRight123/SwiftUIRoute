//
//  BarBackgorundView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

struct BarBackgorundView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
                .ignoresSafeArea(edges: [.top, .bottom])
            
            BlurView(style: .light)
                .ignoresSafeArea(edges: [.top, .bottom])
        }
    }
}

struct BarBackgorundView_Previews: PreviewProvider {
    static var previews: some View {
        BarBackgorundView()
    }
}
