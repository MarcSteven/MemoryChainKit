//
//  PopTransition.swift
//  MCCalendarView
//
//  Created by Marc Steven on 2019/6/16.
//  Copyright © 2019 Marc Steven. All rights reserved.
//

import Foundation
import UIKit


open class PopTransition:NSObject,UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        // Setup the initial view states
        toViewController.view.frame = CGRect(x: -100, y: toViewController.view.frame.origin.y, width: fromViewController.view.frame.size.width, height: fromViewController.view.frame.size.height)
        
        let dimmingView = UIView(frame: CGRect(x: 0,y: 0, width: toViewController.view.frame.width, height: toViewController.view.frame.height))
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.5
        
        toViewController.view.addSubview(dimmingView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        dimmingView.alpha = 0
                        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
                        fromViewController.view.frame = CGRect(x: toViewController.view.frame.size.width, y: fromViewController.view.frame.origin.y, width: fromViewController.view.frame.size.width, height: fromViewController.view.frame.size.height)
        },
                       completion: { finished in
                        dimmingView.removeFromSuperview()
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
    }

