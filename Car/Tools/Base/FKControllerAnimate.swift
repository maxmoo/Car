//
//  FKControllerAnimate.swift
//  FlycoSmart
//
//  Created by hss on 2017/9/30.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class FKControllerAnimate: NSObject,UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = .none
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        // 1
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let fromViewStartFrame = transitionContext.initialFrame(for: fromViewController)
        let toViewEndFrame = transitionContext.finalFrame(for: toViewController)
        var fromViewEndFrame = fromViewStartFrame
        var toViewStartFrame = toViewEndFrame
        
        // 2
        if operation == .push {
            toViewStartFrame.origin.y -= toViewEndFrame.size.height
        } else if operation == .pop {
            fromViewEndFrame.origin.y -= fromViewStartFrame.size.height
            containerView.sendSubview(toBack: toView)
        }
        
        fromView.frame = fromViewStartFrame
        toView.frame = toViewStartFrame
        
        // 3
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView.frame = fromViewEndFrame
            toView.frame = toViewEndFrame
        }, completion: { _ in
            // 4
            transitionContext.completeTransition(true)
        })
    }
}
