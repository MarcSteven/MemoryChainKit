//
//  UIWindowExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
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
  
  class var key: UIWindow {
    guard let keyWindow = UIApplication.shared.keyWindow else { fatalError("Fatal Error: now window is set to keyWindow") }
    return keyWindow
  }
  
  class var keySafeAreaInsets: UIEdgeInsets {
    guard #available(iOS 11.0, *) else { return .zero }
    return UIWindow.key.safeAreaInsets
  }
}
