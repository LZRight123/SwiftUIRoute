//
//  WelcomeView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var vm = WelcomeViewModel()
    
    var body: some View {
        ZStack {
            Text("欢迎来到欢迎页")
        }
    }
}

extension WelcomeView: Routable {
    var page: Route.Page {
        .welcome
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
