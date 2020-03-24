//
// MemoryChainkIT

// Copyright © 2017 Marc Steven
// MIT license, see LICENSE file for details
//


import UIKit

public enum AnimationStatus {
    case began,cancelled,end
}
public enum AnimationDirection {
    case `in`,out
}

open class TransitionAnimator:NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    open var direction:AnimationDirection = .in
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        direction = .in
        return self
    }
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        direction = .out
        return self
    }
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let context = TransitionContext(transitionContext: transitionContext) else {
            return transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        context.from.view.frame = context.containerView.bounds
        context.to.view.frame = context.containerView.bounds
        if direction == .in  {
            //add destination view to Container
            context.containerView.addSubview(context.to.view)
            
        }
        transition(context, direction: direction)
                }
    open func transition(_ context:TransitionContext,
                     direction:AnimationDirection) {
    fatalError(because: .subclassMustImplement)

    }
    open func transitionDuration(using transitionContext:UIViewControllerContextTransitioning?) ->TimeInterval {
        fatalError(because: .subclassMustImplement)
    }
}

