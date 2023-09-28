//
//  TestView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

struct TestView: View , Routable {
    var page: Route.Page { .test }
    
    @State private var text: String = ""
    @State private var isShowLoading = true
    
    var body: some View {
        NDScaffold(
            isShowLoading: isShowLoading,
            title: "测试一下",
            bottomBar: {
                NDBottomBar {
                    HStack {
                        Text("bottomBar")
                            .onTapGesture {
                                isShowLoading.toggle()
                            }
                    }
                }
            }
        ) {
            VStack {
                Spacer()
//                NDLottieView(lottieFlie: "loading_gray")
//                    .loopMode(.loop)
//                    .play()
//                    .frame(width: 77, height: 77)

                TextField("Enter text", text: $text)
                              .textFieldStyle(RoundedBorderTextFieldStyle())
                              .padding()
                Text("123")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
