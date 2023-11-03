//
//  UIApplicationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(.com/MarcSteven). All rights reserved.
//

import UIKit
import AdSupport

public extension UIApplication {
    //广告标识符
    static var IDFA: String? {
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}


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
// MARK: TopViewController

extension UIApplication {
    open class func topViewController(_ base: UIViewController? = UIApplication.sharedOrNil?.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }

        return base
    }

    
    /// Iterates through `windows` from top to bottom and returns the visible window.
    ///
    /// - Returns: Returns an optional window object based on visibility.
    /// - Complexity: O(_n_), where _n_ is the length of the `windows` array.
    open var visibleWindow: UIWindow? {
        windows.reversed().first { !$0.isHidden }
    }
}

// MARK: UIWindow - TopViewController

