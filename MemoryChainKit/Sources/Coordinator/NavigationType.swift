//
//  NavigationType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit



public protocol NavigationType {
    @discardableResult
    func popToRootViewController(animated:Bool)->[UIViewController]?
    
    @discardableResult
    func popToViewController(_ viewController:UIViewController,
                             animated:Bool)->[UIViewController]?
    
    @discardableResult
    func popViewController(animated:Bool)->UIViewController?
    
    func push(_ viewController:UIViewController,animated:Bool,
              completion:(()->Void)?)
    func setRootViewController(_ viewController: UIViewController,
                               animated:Bool)
}

public extension NavigationType {
    func push(_ viewController:UIViewController,animated:Bool) {
        push(viewController, animated: animated, completion: nil)
    }
    
}
