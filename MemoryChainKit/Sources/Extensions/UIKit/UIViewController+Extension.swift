//
//  UIViewController+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/22.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension  UIViewController {
    func install(_ child:UIViewController) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
    /// embed inNavigationController
    func embedInNavigationControllerIfNeeded() ->UIViewController {
        guard canBeEmbededInNavigationController else {
            return self
        }
        return NavigationController(rootViewController: self)
    }
    private var canBeEmbededInNavigationController:Bool {
        switch self {
        case is NavigationController, is UITabBarController:
            return false
            
        default:
            return true
        }
    }
    /// Removes the view controller from its parent.
     func removeFromContainerViewController() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    /// A boolean value to determine whether the view controller is the root view controller of
    /// `UINavigationController` or `UITabBarController`.
     var isRootViewController: Bool {
        if let rootViewController = navigationController?.rootViewController {
            return rootViewController == self
        }

        return tabBarController?.isRootViewController(self) ?? false
    }

    /// A boolean value to determine whether the view controller is being popped or is showing a subview controller.
     var isBeingPopped: Bool {
        if isMovingFromParent || isBeingDismissed {
            return true
        }

        if let viewControllers = navigationController?.viewControllers, viewControllers.contains(self) {
            return false
        }

        return false
    }

     var isModal: Bool {
        if presentingViewController != nil {
            return true
        }

        if presentingViewController?.presentedViewController == self {
            return true
        }

        if let navigationController = navigationController, navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        }

        if (tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil {
            return true
        }

        return false
    }

    /// A boolean value indicating whether the view is currently loaded into memory
    /// and presented on the screen.
     var isPresented: Bool {
        isViewLoaded && view.window != nil
    }

    /// A boolean value indicating whether the home indicator is currently present.
     var isHomeIndicatorPresent: Bool {
        view.safeAreaInsets.bottom > 0
    }

    /// Only `true` iff `isDeviceLandscape` and `isInterfaceLandscape` both are `true`; Otherwise, `false`.
     var isLandscape: Bool {
        isDeviceLandscape && isInterfaceLandscape
    }

     var isInterfaceLandscape: Bool {
        UIApplication.sharedOrNil?.statusBarOrientation.isLandscape ?? false
    }

    /// Returns the physical orientation of the device.
     var isDeviceLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }

    /// This value represents the physical orientation of the device and may be different
    /// from the current orientation of your application’s user interface.
    ///
    /// - seealso: `UIDeviceOrientation` for descriptions of the possible values.
     var deviceOrientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }


    func addFullScreen(childViewController child:UIViewController) {
        guard child.parent == nil else {
            return
        }
        addChild(child)
        view.addSubview(child.view)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: child.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ]
        constraints.forEach {$0.isActive = true}
        view.addConstraints(constraints)
        
        child.didMove(toParent: self)
    }
    func remove(childViewController child:UIViewController?) {
        guard let child = child else {
            return
        }
        guard child.parent != nil else {
            return
        }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

public extension UIViewController {
    func hideNavigationBarOnTap() {
        if self.navigationController?.navigationBar.isHidden == true  {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }else if self.navigationController?.navigationBar.isHidden == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}
