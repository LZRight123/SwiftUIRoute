//
//  WelcomeViewModel.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    
    init() {
        Task {
            LocalUserMananger.shared.commonInit()
            await localDealy(dealy: 100)
            DispatchQueue.main.async {
                ndlog(Thread.current)
                RouteStore.shared.routeToMain()
            }
        }
    }

}
