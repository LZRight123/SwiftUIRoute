//
//  RouteStore.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI
import PanModal

final class RouteStore: NSObject, ObservableObject {
    static let shared = RouteStore()
    
    //    private var isPad: Bool {
    //        UIDevice.current.userInterfaceIdiom == .pad
    //    }
    private(set) var window: UIWindow?
    func configWindow(window: UIWindow) {
        window.rootViewController = welcome
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private(set) lazy var welcome: RouteNavigationController = {
        let page = WelcomeView()
        let rootViewController = RouteViewController(
            route: page.route,
            content: page
        )
        let result = RouteNavigationController(rootViewController: rootViewController)
        return result
    }()
    
    private(set) lazy var rootViewController: RouteNavigationController = {
        let page = MainView()
        let rootViewController = RouteViewController(
            route: page.route,
            content: page
        )
        let result = RouteNavigationController(rootViewController: rootViewController)
        return result
    }()
}


/// 路由
extension RouteStore {
    func present<Content>(
        _ content: Content,
        modal: UIModalPresentationStyle? = nil,
        transition: UIViewControllerTransitioningDelegate? = nil,
        animated: Bool = true
    ) where Content: View & Routable {
        let viewController = RouteViewController(
            route: content.route,
            content: content
        )
       
        switch content.page {
        case .sheet:
            viewController.modalPresentationStyle = .custom
            viewController.view.backgroundColor = .clear
            viewController.transitioningDelegate = PanModalPresentationDelegate.default
            present(viewController, animated: animated)
        case .alert:
            viewController.modalPresentationStyle = .custom
            viewController.view.backgroundColor = .clear
            viewController.transitioningDelegate = FullscreenAnimatorDelegate.default
            present(viewController, animated: animated)
        default:
            let navigationController = makeRouteNavigationController(
                viewController,
                modalStyle: modal,
                backgroundColor: .clear
            )
            navigationController.transitioningDelegate = transition
            present(navigationController, animated: animated)
        }
       
       
    }
    
    
    func push<Content>(_ content: Content) where Content: View & Routable {
        let viewController = RouteViewController(
            route: content.route,
            content: content
        )
        push(viewController)
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
        if (topViewController as? Routable)?.page != .main {
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
    /// 栈顶 VC:
    /// - iPhone: 屏幕上正在展示的 VC, 当没有任何被 Present | Push 的视图时, 为 `SecondaryVC`
    /// - iPad: 同 iPhone 逻辑, 虽然有主屏幕, 但由于 `SecondaryVC` 会一直存在的原因, TopVC 永远不会是 `PrimaryVC`
    var topViewController: UIViewController? {
        //        let vc = UIViewController.topViewController()
        //        return vc
        var result: UIViewController? = rootViewController
        while result?.top != nil {
            result = result?.top
        }
        return result
    }
    
    /// 栈顶 Page
    var topPage: Route.Page? {
        (topViewController as? Routable)?.page
    }
    
    /// 记录控制器堆栈
    var breadPath: String {
        /// 因为 present 操作都是在 topVC 的 nav
        var presentedViewController: UINavigationController? = rootViewController //topViewController?.navigationController
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
        var presentedViewController = rootViewController.presentedViewController as? UINavigationController
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
