//
//  UIWindowExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIWindow {
    func topViewController()->UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            }else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            }else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            }else {
                break
            }
        }
        return top
    }
}
public extension UIWindow {
    func setRootViewController(_ viewController:UIViewController) {
        if rootViewController == viewController {
            return
        }
        if let rootVC = (rootViewController as? UINavigationController)?.rootViewController,
            rootVC == viewController{
            return
        }
        rootViewController = viewController.embedInNavigationControllerIfNeeded()
        makeKeyAndVisible()
    }
}

public extension UIWindow {
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {

        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }

        if rootVC?.presentedViewController == nil {
            return rootVC
        }

        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }

            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }

            return getVisibleViewController(presented)
        }
        return nil
    }
}

