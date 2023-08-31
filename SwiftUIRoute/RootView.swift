//
//  RootView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack  {
            Text("Root View")
            Button("上一步") {
                RouteStore.shared.pop()
            }
            Button("下一步") {
                RouteStore.shared.present(
                    RoutePlaceholderView(),
                    modalStyle: .fullScreen
                )
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onPageChanged { page in
            RouteStore.shared.breadPath
        
        }
    }
}

extension RootView: Routable {
    var page: Route.Page {
        .root
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}


