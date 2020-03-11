//
//  UIApplicationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public extension UIApplication {
    class func isFirstToLaunch() ->Bool {
        if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
        
    }

    var isKeyboardPresented:Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: {$0.isKind(of: keyboardWindowClass)}) {
            return true
        } else {
            return false
        }
    }

    class func showNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    class func hideNetworkActivity() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false 
        }
    }
}
