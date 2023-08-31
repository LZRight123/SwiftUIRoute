//
//  Route.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import UIKit

protocol Routable {
    var page: Route.Page { get }
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var presentationControllerShouldDismiss: Bool { get }
    var route: Route{ get }
}

extension Routable {
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        .none
    }

    var statusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    var presentationControllerShouldDismiss: Bool {
        false
    }

    var route: Route {
        Route(
            page: page,
            keyboardDismissMode: keyboardDismissMode,
            statusBarStyle: statusBarStyle,
            presentationControllerShouldDismiss: presentationControllerShouldDismiss
        )
    }
}

struct Route {
    let page: Page
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none
    var statusBarStyle: UIStatusBarStyle = .darkContent
    var presentationControllerShouldDismiss: Bool = false
}
