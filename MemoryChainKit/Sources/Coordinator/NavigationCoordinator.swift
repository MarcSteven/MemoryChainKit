//
//  NavigationCoordinator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol NavigationCoordinator:PresentationCoordinator {
    var navigator:NavigationType{get}
}

public extension NavigationCoordinator {
    func pushCoordinator(_ childCoordinator:_PresentationCoordinator,
                         animated:Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        navigator.push(childCoordinator._rootViewController, animated: animated, completion: {[weak self] in
            self?.removeChildCoordinator(childCoordinator)
            
        })
    }
}
