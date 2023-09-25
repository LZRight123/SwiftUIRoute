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
            await localDealy(dealy: 0)
            DispatchQueue.main.async {
                RouteStore.shared.routeToMain()
            }
        }
    }

}
