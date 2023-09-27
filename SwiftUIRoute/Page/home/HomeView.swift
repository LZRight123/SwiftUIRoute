//
//  HomeView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea(.all)
            
            VStack {
                Button {
                    RouteStore.shared.present(PopView(), modalStyle: .popover)
                } label: {
                    Text("tap me")
                        .foregroundColor(Color.red)
                }

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct PopView: View {
    var body: some View {
        VStack {
//            Spacer()
            ZStack {
                
            }
            .frame(width: 100, height: 200)
            .background(Color.yellow)
            .onTapGesture {
                RouteStore.shared.pop()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}
extension PopView: Routable {
    var page: Route.Page { .sheet }
}
