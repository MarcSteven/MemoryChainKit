//
//  UINavigationControllerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UINavigationController {
    var rootViewController:UIViewController? {
        get {
            viewControllers.first
        }
        set {
            var rootViewController:[UIViewController] = []
            if let viewController = newValue {
                rootViewController = [viewController]
            }
            setViewControllers(rootViewController, animated: false)
        }
    }
    /// Pushes a list of view controller onto the receiver’s stack and updates the
    /// display.
    ///
    /// The object in the viewController parameter becomes the top view controller
    /// on the navigation stack. Pushing a view controller causes its view to be
    /// embedded in the navigation interface. If the animated parameter is `true`,
    /// the view is animated into position; otherwise, the view is simply displayed
    /// in its final location.
    ///
    /// In addition to displaying the view associated with the new view controller
    /// at the top of the stack, this method also updates the navigation bar and
    /// tool bar accordingly. For information on how the navigation bar is updated.
    ///
    /// - Parameters:
    ///   - viewControllers: The view controller to push onto the stack. This object
    ///                     cannot be a tab bar controller.
    ///                     If the view controller is already on the navigation
    ///                     stack, this method throws an exception.
    ///   - animated: Specify `true` to animate the transition or `false` if you do
    ///               not want the transition to be animated.
    ///               You might specify `false` if you are setting up the navigation
    ///               controller at launch time.
    ///   - completion: The block to execute after the presentation finishes.
     func pushViewController(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)? = nil) {
        var vcs = self.viewControllers
        vcs.append(contentsOf: viewControllers)

        CATransaction.animation({
            setViewControllers(vcs, animated: animated)
        }, completinonHandler: completion)
    }

}
