//
//  PresentationBackgroudController.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import UIKit

class PresentationBackgroudController: UIPresentationController {
    let backgroundColor: UIColor
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        backgroundColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView?.frame ?? UIScreen.main.bounds
        containerView?.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        
        let transitionCoordinator = presentedViewController.transitionCoordinator
        dimmingView.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed  {
            dimmingView.removeFromSuperview()
        }
    }
}
