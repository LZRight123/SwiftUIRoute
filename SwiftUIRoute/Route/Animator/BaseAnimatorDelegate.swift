//
//  BaseAnimator.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/9/27.
//

import UIKit

class BaseAnimatorDelegate: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let backgroundColor: UIColor
    
    init(duration: TimeInterval, backgroundColor: UIColor) {
        self.duration = duration
        self.backgroundColor = backgroundColor
    }
    
    /**
     * UIViewControllerTransitioningDelegate
     */
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationBackgroudController(presentedViewController: presented, presenting: presenting, backgroundColor: backgroundColor)
    }
    
    /**
     * UIViewControllerAnimatedTransitioning
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //FIXME: -subclass implement
    }
}

