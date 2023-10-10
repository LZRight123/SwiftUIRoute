//
//  RouteStore+Root.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/25.
//

import SwiftUI

extension RouteStore {
    func routeToMain() {
        if LocalUserMananger.shared.isLogin {
            if LocalUserMananger.shared.userInfo.isNewUser {
                RouteStore.shared.present(PerfectBaseInfoView(), modal: .fullScreen, animated: false)
            } else {
                switch LocalUserMananger.shared.userStep.step {
                case .PetMatch: RouteStore.shared.present(CharacterMatchView(), modal: .fullScreen, animated: false)
                case .AdoptCompletion: RouteStore.shared.present(PetAdoptCompletedView(), modal: .fullScreen, animated: false)
                case .Over: window?.rootViewController = rootViewController
                }
            }
        } else {
            RouteStore.shared.present(LoginView(), modal: .fullScreen, animated: false)
        }
    }
}
