//
//  FullscreenAnimator.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import UIKit
import SwiftUI


class FullscreenAnimatorDelegate: BaseAnimatorDelegate {
    static let `default` = FullscreenAnimatorDelegate(duration: 0.3, backgroundColor: UIColor(Color.black.opacity(0.5)))
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }
        
        // Calls viewWillAppear and viewWillDisappear
        fromVC.beginAppearanceTransition(false, animated: true)
        
        if transitionContext.viewController(forKey: .to)?.isBeingPresented == true {
            let toView = transitionContext.view(forKey: .to)
            toView?.frame = transitionContext.finalFrame(for: toVC)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut,
                animations: {
                    toView?.transform = CGAffineTransform.identity
                },
                completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            )
           
        } else {
            UIView.animate(withDuration: duration * 0.8, animations: {
                transitionContext.view(forKey: .from)?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
