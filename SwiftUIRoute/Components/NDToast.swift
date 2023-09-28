//
//  NDToast.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/28.
//

import SwifterSwift

/// 先用 Toaster
private extension NDToast {
    static func show() {
        NDToast.shared.show()
    }
    
    static func dismiss() {
        NDToast.shared.dismiss()
    }
}

private class NDToast {
    static let shared = NDToast()
    
    private(set) var toastWindow: UIWindow?
    private var workItem: DispatchWorkItem?
    
    fileprivate func show() {
        workItem?.cancel()
        workItem = DispatchWorkItem {
            self.dismiss()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem!)
        
        dismiss()
        makeKeyWindowVisible()
    }
    
    fileprivate func dismiss() {
        toastWindow?.resignKey()
        toastWindow = nil
    }
    
    private func makeKeyWindowVisible() {
        toastWindow = makeToastWindow()
        toastWindow?.makeKeyAndVisible()
    }
}

extension NDToast {
    fileprivate func makeToastWindow() -> UIWindow {
        let window = UIWindow()
        window.windowLevel = UIWindow.Level.normal
        window.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        window.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let vc = UIHostingController(rootView:NDLoaddingView())
        vc.view.backgroundColor = .red
        window.rootViewController = vc
        for windowScene in UIApplication.shared.connectedScenes {
            if (windowScene.activationState == UIScene.ActivationState.foregroundActive) {
                window.windowScene = windowScene as? UIWindowScene
            }
        }
        return window
    }
}
