//
//  UIApplicationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public extension UIApplication {
    static var sharedOrNil:UIApplication? {
        let sharedApplicaitonSelector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: sharedApplicaitonSelector) else {
            return nil
        }
        guard let unmanagedSharedApplication = UIApplication.perform(sharedApplicaitonSelector) else {
            return nil
        }
        return unmanagedSharedApplication.takeUnretainedValue() as? UIApplication
    }
    class func isFirstToLaunch() ->Bool {
        if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
        
    }
        
func topViewController(_ base:UIViewController? = UIApplication.sharedOrNil?.keyWindow?.rootViewController) ->UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return topViewController(selectedViewController)
            }
        }
        if let presentedViewController = base?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return base
    }
    var isKeyboardPresented:Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: {$0.isKind(of: keyboardWindowClass)}) {
            return true
        } else {
            return false
        }
    }

func showNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
func hideNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false 
        }
    }

}
