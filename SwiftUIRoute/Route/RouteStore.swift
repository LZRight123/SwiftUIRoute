//
//  RouteStore.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI

final class RouteStore: NSObject, ObservableObject {
    static let shared = RouteStore()
    
    private var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    private(set) lazy var rootViewController: RouteSplitViewController = {
        let rootView = RootView()
        let rootViewController = RouteViewController(
            route: rootView.route,
            content: rootView
        )
        let placeholderView = RoutePlaceholderView()
        let placeholderViewController = RouteViewController(
            route: placeholderView.route,
            content: placeholderView
        )
        let result = RouteSplitViewController(style: .doubleColumn)
        if isPad {
            // 主屏幕：一直存在不会消失
            result.setViewController(
                makeRouteNavigationController(rootViewController),
                for: .primary
            )
            // 副屏幕：可被替换，但会一直存在
            result.setViewController(
                makeRouteNavigationController(placeholderViewController),
                for: .secondary
            )
        } else {
            // 单屏幕
            result.setViewController(
                makeRouteNavigationController(rootViewController),
                for: .secondary
            )
        }
        return result
    }()
}

/// 路由
extension RouteStore {
    func present<Content>(
        _ content: Content,
        modalStyle: UIModalPresentationStyle? = nil,
        transition: UIViewControllerTransitioningDelegate? = nil
    ) where Content: View & Routable {
        let viewController = RouteViewController(
            route: content.route,
            content: content
        )
        let navigationController = makeRouteNavigationController(
            viewController,
            modalStyle: modalStyle,
            backgroundColor: .clear
        )
        navigationController.transitioningDelegate = transition
        present(navigationController)
        
    }
    
    
    func push<Content>(_ content: Content) where Content: View & Routable {
        if isPad {
            showDetail(content)
        } else {
            let viewController = RouteViewController(
                route: content.route,
                content: content
            )
            push(viewController)
        }
    }
    
    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        // 避免多次重复计算
        let currentViewController = topViewController
        let page = (currentViewController as? Routable)?.page
        print("⬅️ Route Pop: \(page?.rawValue ?? "Unknown")")
        if let nav = currentViewController?.navigationController {
            if nav.viewControllers.count > 1 {
                nav.popViewController(
                    animated: animated,
                    completion: completion
                )
            } else {
                nav.dismiss(
                    animated: animated,
                    completion: {
                        self.postPageChangedNotification()
                        completion?()
                    }
                )
            }
        } else {
            currentViewController?.dismiss(
                animated: animated,
                completion: {
                    self.postPageChangedNotification()
                    completion?()
                }
            )
        }
    }
    
    func popToRoot(animation: Bool = true, completion: (() -> Void)? = nil) {
        if isPad {
            // iPad: 因为右侧 secondaryVC 会一直存在
            // 所以当 topVC 的 navVC 是 secondaryVC 且栈顶 VC 是 topVC 时停止 pop
            if topViewController?.navigationController == secondaryViewController,
               secondaryViewController?.topViewController == topViewController
            {
                completion?()
                return
            }
            pop(animated: animation) { [weak self] in
                self?.popToRoot(
                    animation: animation,
                    completion: completion
                )
            }
        } else {
            // iPhone 上 Top View Controller 不是 root 的话继续 pop
            if (topViewController as? Routable)?.page != .root {
                pop(animated: animation) { [weak self] in
                    self?.popToRoot(
                        animation: animation,
                        completion: completion
                    )
                }
            } else {
                completion?()
            }
        }
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        topViewController?.navigationController?
            .present(viewController, animated: animated, completion: nil)
    }
    
    private func showDetail<Content>(_ content: Content) where Content: View & Routable {
        let viewController = RouteViewController(
            route: content.route,
            content: content
        )
        let navigationController = makeRouteNavigationController(viewController)
        showDetail(navigationController)
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        topViewController?.navigationController?
            .pushViewController(
                viewController,
                animated: animated
            )
    }
    
    private func showDetail(_ viewController: UIViewController) {
        rootViewController.showDetailViewController(viewController, sender: nil)
    }
}

/// 控制器相关
extension RouteStore {
    var primaryViewController: UINavigationController? {
        rootViewController.viewController(for: .primary) as? UINavigationController
    }
    
    var secondaryViewController: UINavigationController? {
        rootViewController.viewController(for: .secondary) as? UINavigationController
    }
    
    /// 栈顶 VC:
    /// - iPhone: 屏幕上正在展示的 VC, 当没有任何被 Present | Push 的视图时, 为 `SecondaryVC`
    /// - iPad: 同 iPhone 逻辑, 虽然有主屏幕, 但由于 `SecondaryVC` 会一直存在的原因, TopVC 永远不会是 `PrimaryVC`
    var topViewController: UIViewController? {
        let vc = UIViewController.topViewController()
        return vc
//        var result: UIViewController? = rootViewController
//        while result?.top != nil {
//            result = result?.top
//        }
//        return result
    }
    
    /// 栈顶 Page
    var topPage: Route.Page? {
        (topViewController as? Routable)?.page
    }
    
    /// 记录控制器堆栈
    var breadPath: String {
        /// 因为 present 操作都是在 topVC 的 nav
        var presentedViewController = topViewController?.navigationController//secondaryViewController
        var path: String = "tabbar 的值"
        while presentedViewController != nil {
            presentedViewController?.viewControllers.forEach {
                if let page = ($0 as? Routable)?.page {
                    path.append("/\(page.rawValue)")
                }
            }
            presentedViewController = presentedViewController?.presentedViewController as? UINavigationController
        }
        print("⏺ bread path: \(path)")
        return path
    }
    
    /// 若控制器堆栈中存在 Sheet 出现的 Page, 返回 true, 否则返回 false
    var isInPageSheet: Bool {
        // 由于所有的 Push/Present 操作都不会在 `PrimaryVC` 上进行, 因此只需要遍历 `SecondaryVC` 的 presentedVC 栈
        var presentedViewController = secondaryViewController?.presentedViewController as? UINavigationController
        while presentedViewController != nil {
            if presentedViewController?.modalPresentationStyle == .pageSheet {
                return true
            }
            presentedViewController = presentedViewController?.presentedViewController as? UINavigationController
        }
        return false
    }
}

/// 通知
extension Notification.Name {
    static let routePageDidChanged: Notification.Name  = Notification.Name("RoutePageChanged")
}
private extension RouteStore {
    func postPageChangedNotification() {
        let page = (topViewController as? Routable)?.page
        NotificationCenter.default
            .post(
                name: .routePageDidChanged,
                object: page
            )
    }
}

private extension RouteStore {
    func makeRouteNavigationController(
        _ viewController: UIViewController,
        modalStyle: UIModalPresentationStyle? = nil,
        backgroundColor: UIColor? = nil
    ) -> UINavigationController {
        let navigationController = RouteNavigationController(rootViewController: viewController)
        if let modalStyle = modalStyle {
            navigationController.modalPresentationStyle = modalStyle
        }
        if let backgroundColor = backgroundColor {
            viewController.view.backgroundColor = backgroundColor
        }
        if let viewController = viewController as? UIAdaptivePresentationControllerDelegate {
            navigationController.presentationController?.delegate = viewController
        }
        return navigationController
    }
}
