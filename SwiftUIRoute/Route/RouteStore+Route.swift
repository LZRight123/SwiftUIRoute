//
//  RouteStore+Root.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

extension RouteStore {
    func routeToMain() {
        window?.rootViewController = rootViewController
        RouteStore.shared.present(LoginView(), modalStyle: .fullScreen, animated: false)
    }
}
