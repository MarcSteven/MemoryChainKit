//
//  PresentationCoordinator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol _PresentationCoordinator:Coordinator {
    var _rootViewController:UIViewController {get}
}
public protocol PresentationCoordinator:_PresentationCoordinator {
    associatedtype ViewController:UIViewController
    var rootViewController:ViewController {get}
}

public extension PresentationCoordinator {
    var _rootViewController: UIViewController {
        return rootViewController
    }
    
}
//MARK: - presentation method
public extension PresentationCoordinator {
    func presentCoordinator(_ childCoordinator:_PresentationCoordinator,
                            animated:Bool) {
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
        rootViewController.present(childCoordinator._rootViewController, animated: animated, completion: nil)
    }
    func dismissCoordinator(_ childCoordinator:_PresentationCoordinator,
                            animated:Bool,
                            completion:(()->Void)? = nil) {
        childCoordinator._rootViewController.dismiss(animated: animated, completion: completion)
        self.removeChildCoordinator(childCoordinator)
    }
    
}
