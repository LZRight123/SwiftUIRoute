//
//  MainView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NDScaffold(
            bottomBar: {
                MainTabBar(onClickItem: {
                    vm.currentTabBarType = $0
                })
                .environmentObject(vm)
            }
        ) {
            ZStack {
                switch vm.currentTabBarType {
                case .one: HomeView()
                default:
                    Button("LOGIN") {
                        RouteStore.shared.present(LoginView())
                    }

                }
            }
            .frame(maxWidth: .infinity ,maxHeight: .infinity)
            .background(Color.red)
            .ignoresSafeArea(.all)
        }
    }
    
}

extension MainView: Routable {
    var page: Route.Page { .main }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
