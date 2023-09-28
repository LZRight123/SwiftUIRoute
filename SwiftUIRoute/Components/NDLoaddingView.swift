//
//  NDLoaddingView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwiftUI

struct NDLoaddingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.01).ignoresSafeArea(.all)
            NDLottieView(lottieFlie: "loading_gray")
                .loopMode(.loop)
                .play()
                .frame(width: 88, height: 88)
        }
    }
}

struct NDLoaddingView_Previews: PreviewProvider {
    static var previews: some View {
        NDLoaddingView()
    }
}
