//
//  HUD.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import Foundation

extension NDProgress {
    static func show() {
        NDProgress.shared.show()
    }
    
    static func dismiss() {
        NDProgress.shared.dismiss()
    }
}

class NDProgress {
    static let shared = NDProgress()
    
    private(set) var hudWindow: UIWindow?
    
    fileprivate func show() {
        dismiss()
        makeKeyWindowVisible()
    }
    
    fileprivate func dismiss() {
        hudWindow?.resignKey()
        hudWindow = nil
    }
    
    private func makeKeyWindowVisible() {
        hudWindow = makeHUDWindow()
        hudWindow?.makeKeyAndVisible()
    }
}

extension NDProgress {
    fileprivate func makeHUDWindow() -> UIWindow {
        let hudWindow = UIWindow()
        hudWindow.windowLevel = UIWindow.Level.normal
        hudWindow.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        let vc = UIHostingController(rootView:NDLoaddingView())
        vc.view.backgroundColor = .clear
        hudWindow.rootViewController = vc
        for windowScene in UIApplication.shared.connectedScenes {
            if (windowScene.activationState == UIScene.ActivationState.foregroundActive) {
                hudWindow.windowScene = windowScene as? UIWindowScene
            }
        }
        
        return hudWindow
    }
}
