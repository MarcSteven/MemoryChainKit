//
//  TransitionContext.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

open class TransitionContext {
    public let context:UIViewControllerContextTransitioning
    public let to:UIViewController
    public let from:UIViewController
    public let containerView:UIView
    
    public init?(transitionContext:UIViewControllerContextTransitioning){
        guard let to = transitionContext.viewController(forKey: .to),
            let from = transitionContext.viewController(forKey: .from)
            else {
            return nil
        }
        self.context = transitionContext
        self.to = to
        self.from = from
        self.containerView = transitionContext.containerView
        
    }
    open func completeTransition() {
        context.completeTransition(!context.transitionWasCancelled)
    }
}
