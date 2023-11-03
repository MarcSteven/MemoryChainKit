//
//  Navigator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit
public final class Navigator:NSObject,NavigationType {
    public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let popViewControllers = navigationController.popToViewController(viewController, animated: animated) {
            popViewControllers.forEach {runCompletion(for: $0)}
            return popViewControllers
        }
        return nil
    }
    
    public func popViewController(animated: Bool) -> UIViewController? {
        if let popedController = navigationController.popViewController(animated: animated) {
            runCompletion(for: popedController)
            return popedController
            
        }
        return nil

    }
    
    public func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        completions.forEach {$0.value()}
        completions = [:]
        navigationController.setViewControllers([viewController], animated: animated)

    }
    
    //MARK: - private properties
    private let navigationController:UINavigationController
    private var completions:[UIViewController:() ->Void]
    public init(navigationController:UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        
        self.navigationController.delegate = self
        
    }
}
//MARK: - Navigation method
public extension Navigator {
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if let popedControllers = navigationController.popToRootViewController(animated: animated) {
            popedControllers.forEach {runCompletion(for: $0)}
            return popedControllers
        }
        return nil
    }
        func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[viewController] = completion
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    }
//MARK: - UINavigationController delegate
extension Navigator:UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let popViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) ,
            !navigationController.viewControllers.contains(popViewController)
        else {
            return
        }
        runCompletion(for: popViewController)
    }
}

//MARK: - private helper method
private extension Navigator {
    func runCompletion(for viewController:UIViewController) {
        guard let completion = completions[viewController] else {
            return
        }
        completion()
        completions.removeValue(forKey: viewController)
    }
}
