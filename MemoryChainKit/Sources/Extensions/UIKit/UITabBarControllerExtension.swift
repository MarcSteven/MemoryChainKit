//
//  UITabBarControllerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public  extension UITabBarController {
    func isRootViewController(_ viewController:UIViewController) ->Bool {
        guard let viewControllers = viewControllers else {
            return false
        }
        if let navigationController =  viewController.navigationController {
            return viewControllers.contains(navigationController)
        }
        return viewControllers.contains(viewController)
    }
    func hasRootViewController(_ viewController:UIViewController) ->Bool {
        guard let viewControllers = viewControllers else {
            return false
        }
        if let navigationController = viewController.navigationController {
            return viewControllers.contains(navigationController)
        }
        return viewControllers.contains(viewController)
    }
    
    func hideTabBar(_ isHidden:Bool,animated:Bool) {
        let frame = tabBar.frame
        let offsetY = isHidden ? frame.size.height : -frame.size.height
        var newFrame = frame
        newFrame.origin.y = view.frame.maxY + offsetY
        tabBar.isHidden = false
        UIView.animate(withDuration: animated ? 0.35 :0.0, delay: 0, options: .beginFromCurrentState, animations: {
            self.tabBar.frame = newFrame
        }, completion: {completion in
            if completion {
                self.tabBar.isHidden = isHidden
            }
        })
    }
}

