//
//  RouteNavigationController.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI
import UIKit

class RouteNavigationController: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.isHidden = true
        overrideUserInterfaceStyle = .light
        interactivePopGestureRecognizer?.delegate = self
    }

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}

extension RouteNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}

extension UINavigationController {
    func popViewController(animated: Bool = true, completion: (() -> Void)?) {
        if let completion = completion {
            // https://stackoverflow.com/a/36809827
            popViewController(animated: animated)
            if animated, let coordinator = transitionCoordinator {
                coordinator.animate(alongsideTransition: nil) { _ in
                    completion()
                }
            } else {
                completion()
            }
        } else {
            popViewController(animated: animated)
        }
    }
}
