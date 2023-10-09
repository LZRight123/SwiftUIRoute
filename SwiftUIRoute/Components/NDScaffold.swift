//
//  NDScaffold.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwiftUI

extension NDScaffold {
    init(
        bacgroundColor: Color = .b2,
        contentColor: Color = .f1,
        isShowLoading: Bool = false,
        title: String,
        navBar: (() -> any View)? = nil,
        bottomBar: (() -> any View)? = nil,
        content: () -> Content
    ) {
        self.init(
            bacgroundColor: bacgroundColor,
            contentColor: contentColor,
            isShowLoading: isShowLoading,
            topBar: {
                NDNavBar(
                    leading: {
                        Button {
                            RouteStore.shared.pop()
                        } label: {
                            Text("返回")
                            Image(systemName: "back")
                        }
                    },
                    trailing: navBar,
                    content: {
                        Text(title)
                            .ndfont(.title2, textColor: .f1)
                            .fontWeight(.bold)
                    }
                )
            },
            bottomBar: bottomBar,
            content: content
        )
    }
}

struct NDScaffold<Content: View>: View {
    let bacgroundColor: Color
    let contentColor: Color
    let isShowLoading: Bool
    let topBar: (any View)?
    let bottomBar: (any View)?
    let content: Content
    
    init(
        bacgroundColor: Color = .b2,
        contentColor: Color = .f1,
        isShowLoading: Bool = false,
        topBar: (() -> any View)? = nil,
        bottomBar: (() -> any View)? = nil,
        content: () -> Content
    ) {
        self.bacgroundColor = bacgroundColor
        self.contentColor = contentColor
        self.isShowLoading = isShowLoading
        self.topBar = topBar?()
        self.bottomBar = bottomBar?()
        self.content = content()
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack{
                bacgroundColor.ignoresSafeArea(.all)
                content
                    .foregroundColor(contentColor)
            }
            .ndoverlayer(isShowLoading, content: {
                loading
            })
            .safeAreaInset(edge: .top, spacing: 0) {
                if let topBar = topBar {
                    AnyView(topBar)
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if let bottomBar = bottomBar {
                    AnyView(bottomBar)
                }
            }
        } else {
            ZStack{
                bacgroundColor.ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    if let topBar = topBar {
                        AnyView(topBar)
                    }
                    Spacer(minLength: 0)
                    ZStack {
                        content
                            .foregroundColor(contentColor)
                    }
                    .ndoverlayer(isShowLoading, content: {
                        loading
                    })
                    Spacer(minLength: 0)
                    if let bottomBar = bottomBar {
                        AnyView(bottomBar)
                    }
                }
            }
        }
    }
    
    var loading: some View {
        NDLoaddingView()
    }
}

struct NDScaffold_Previews: PreviewProvider {
    static var previews: some View {
        NDScaffold(
            content: {
                Text("123")
            }
        )
    }
}
