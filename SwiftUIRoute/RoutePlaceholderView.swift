//
//  RoutePlaceholderView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI

struct RoutePlaceholderView: View {
    var body: some View {
        VStack  {
            Text("RoutePlaceholderView!")
            Button("上一步") {
                RouteStore.shared.pop()
            }
            Button("下一步") {
                RouteStore.shared.push(RoutePlaceholderView())
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        
    }
}

extension RoutePlaceholderView: Routable {
    var page: Route.Page {
        .placeholder
    }
}

struct RoutePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        RoutePlaceholderView()
    }
}
