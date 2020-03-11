//
//  NavigationController.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/10.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit


open  class NavigationController: UINavigationController {
    
    var backBtn:UIButton = {
        // 设置返回按钮属性
        let backBtn = UIButton()
        backBtn.addTarget(self, action:#selector(goBack), for: .touchUpInside)
        return backBtn
    }()
        
    //MARK: - view lifeCycle
    override  open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if children.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backBtn)
            viewController.hidesBottomBarWhenPushed=true
        }
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
    override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
    @objc func goBack() {
        popViewController(animated: true)
    }
}
//MARK: - uigesture delegate
extension NavigationController :UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        
        return true
    }
}
//MARK: - UINavigationDelegate
extension NavigationController :UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
