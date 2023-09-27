//
//  TestView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

struct TestView: View , Routable {
    var page: Route.Page { .test }
    
    var body: some View {
        Color.red
            .ndnavbar {
                Text("title")
                    .foregroundColor(.acc1)
                    .font(.system(size: 12))
            } trailing: {
                Text("trailing")
                    .foregroundColor(.f1)
            }
            .ndbottomBar {
                Text("ndbottomBar")
                    .padding(50)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
