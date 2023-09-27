//
//  RouteViewController.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/8/31.
//

import SwiftUI
import PanModal

class RouteViewController<Content>: UIHostingController<Content>, Routable, CustomSheetable, UIAdaptivePresentationControllerDelegate where Content: View {
    private(set) var targetPanModal: CustomSheetable?
        
    let route: Route
//    private var targetPanModal: PanModalPresentable?
    init(route: Route, content: Content) {
        self.route = route
        targetPanModal = content as? CustomSheetable
        super.init(rootView: content)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
    
    // MARK: Routable

    var page: Route.Page {
        route.page
    }

    var keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        route.keyboardDismissMode
    }

    var statusBarStyle: UIStatusBarStyle {
        route.statusBarStyle
    }

    var presentationControllerShouldDismiss: Bool {
        route.presentationControllerShouldDismiss
    }

    // MARK: UIAdaptivePresentationControllerDelegate

    func presentationControllerShouldDismiss(_: UIPresentationController) -> Bool {
        presentationControllerShouldDismiss
    }

    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        UIScrollView.appearance().keyboardDismissMode = keyboardDismissMode
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.resignFirstResponder()
        UIScrollView.appearance().keyboardDismissMode = .none
        super.viewWillDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default
            .post(
                name: .routePageDidChanged,
                object: page
            )
    }
}
