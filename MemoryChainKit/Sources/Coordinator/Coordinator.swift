//
//  Coordinator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol Coordinator:AnyObject {
    var childCoordinators:[Coordinator] {get set}
    
    func start()
    
}

public extension Coordinator {
    // Add child coordinator the parent, preventing it from getting deallocated memory
    func addChildCoordinator(_ childCoordinator:Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    //remove child coordinator from its parents, releaseing it from memory
    func removeChildCoordinator(_ childCoordinator:Coordinator) {
        childCoordinators = childCoordinators.filter({$0 !== childCoordinator})
    }
}
