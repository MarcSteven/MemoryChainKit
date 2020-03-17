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
}
