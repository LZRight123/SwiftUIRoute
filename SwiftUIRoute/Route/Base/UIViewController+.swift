//
//  UIViewController+.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import UIKit

extension UIViewController {
    var top: UIViewController? {
        if let splitViewController = self as? UISplitViewController {
            if let secondaryController = splitViewController.viewController(for: .secondary) {
                return secondaryController
            }
        } else if let navigationController = self as? UINavigationController {
            return navigationController.topViewController
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController
        }
        return nil
    }
    
     static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
