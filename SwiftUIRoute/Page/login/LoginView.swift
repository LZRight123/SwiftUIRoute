//
//  LoginView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea(.all)
            
            
            Button {
                RouteStore.shared.pop()
            } label: {
                Text("login in")

            }

        }
    }
}

extension LoginView: Routable {
    var page: Route.Page { .login }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
