//
//  UIViewController+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/22.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
public  extension UIViewController {

    var isTopAndVisible: Bool {
        return isVisible && isTopViewController
    }

    var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }

    var isTopViewController: Bool {
        if self.navigationController != nil {
            return self.navigationController?.visibleViewController === self
        } else if self.tabBarController != nil {
            return self.tabBarController?.selectedViewController == self && self.presentedViewController == nil
        } else {
            return self.presentedViewController == nil && self.isVisible
        }
    }
}
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
        if #available(iOS 11, *) {
            return view.safeAreaInsets.bottom > 0
        } else {
            return false
        }
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
public extension UIViewController {
    func hideNavigationBackTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
}
public extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func hideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
//Usage : called this method of hideKeyboardOnTap in viewDidLoad()
public extension UIViewController {
    private struct AssociatedKeys {
           static var floatingButton:UIButton?
       }
       /// floating button
       var floatingButton:UIButton? {
           get {
               guard let value = objc_getAssociatedObject(self, &AssociatedKeys.floatingButton) as? UIButton else {
                   return  nil
               }
               return value
           }
           set {
               objc_setAssociatedObject(self, &AssociatedKeys.floatingButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           }
       }
       //Add floating button
       func addFloatingButton(_ usingImage:UIImage) {
               // Customize your own floating button UI
               let button = UIButton(type: .custom)
               let image = usingImage.withRenderingMode(.alwaysTemplate)
               button.tintColor = .white
               button.setImage(image, for: .normal)
              
               button.layer.shadowColor = UIColor.black.cgColor
               button.layer.shadowRadius = 3
               button.layer.shadowOpacity = 0.12
               button.layer.shadowOffset = CGSize(width: 0, height: 1)
               button.sizeToFit()
               let buttonSize = CGSize(width: 64, height: 56)
               let rect = UIScreen.main.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
               button.frame = CGRect(origin: CGPoint(x: rect.maxX - 15, y: rect.maxY - 50), size: CGSize(width: 60, height: 60))
               // button.cornerRadius = 30 -> Will destroy your shadows, however you can still find workarounds for rounded shadow.
               button.autoresizingMask = []
               view.addSubview(button)
               floatingButton = button
               let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire(panGesture:)))
               floatingButton?.addGestureRecognizer(panner)
               snapButtonToSocket()
           }
       
       /// pangestrure did fire
       /// - Parameter panner: panGestureRecognizer
           @objc fileprivate func panDidFire(panGesture: UIPanGestureRecognizer) {
               guard let floatingButton = floatingButton else {return}
               let offset = panGesture.translation(in: view)
               panGesture.setTranslation(CGPoint.zero, in: view)
               var center = floatingButton.center
               center.x += offset.x
               center.y += offset.y
               floatingButton.center = center

               if panGesture.state == .ended || panGesture.state == .cancelled {
                   UIView.animate(withDuration: 0.3) {
                       self.snapButtonToSocket()
                   }
               }
           }
       /// snap button to socket
           fileprivate func snapButtonToSocket() {
               guard let floatingButton = floatingButton else {return}
               var bestSocket = CGPoint.zero
               var distanceToBestSocket = CGFloat.infinity
               let center = floatingButton.center
               for socket in sockets {
                   let distance = hypot(center.x - socket.x, center.y - socket.y)
                   if distance < distanceToBestSocket {
                       distanceToBestSocket = distance
                       bestSocket = socket
                   }
               }
               floatingButton.center = bestSocket
           }
       
       /// sockets
           fileprivate var sockets: [CGPoint] {
               let buttonSize = floatingButton?.bounds.size ?? CGSize(width: 0, height: 0)
               let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
               let sockets: [CGPoint] = [
                   CGPoint(x: rect.minX + 15, y: rect.minY + 30),
                   CGPoint(x: rect.minX + 15, y: rect.maxY - 50),
                   CGPoint(x: rect.maxX - 15, y: rect.minY + 30),
                   CGPoint(x: rect.maxX - 15, y: rect.maxY - 50)
               ]
               return sockets
           }
           // Custom socket position to hold Y position and snap to horizontal edges.
           // You can snap to any coordinate on screen by setting custom socket positions.
           fileprivate var horizontalSockets: [CGPoint] {
               guard let floatingButton = floatingButton else {return []}
               let buttonSize = floatingButton.bounds.size
               let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
               let y = min(rect.maxY - 50, max(rect.minY + 30, floatingButton.frame.minY + buttonSize.height / 2))
               let sockets: [CGPoint] = [
                   CGPoint(x: rect.minX + 15, y: y),
                   CGPoint(x: rect.maxX - 15, y: y)
               ]
               return sockets
           }
   }
public extension UIViewController {
    @objc var topBarHeight: CGFloat {
        if #available(*, iOS 13) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
        }
    } 
}

public extension UIViewController {
    /// iOS's `isBeingDismissed` can return `false` if the VC is being dismissed indirectly, by one of its ancestors
    /// being dismissed.  This method returns `true` if the VC is being dismissed directly, or if one of its ancestors is being
    /// dismissed.
    ///
    func isBeingDismissedDirectlyOrByAncestor() -> Bool {
        guard !isBeingDismissed else {
            return true
        }

        var current: UIViewController = self

        while let ancestor = current.parent {
            guard !ancestor.isBeingDismissed else {
                return true
            }

            current = ancestor
        }

        return false
    }
}

import ARKit

public extension UIViewController {
    var hasARView:Bool {
        let views = self.view.subviews
        for v in views {
            if v is ARSCNView || v is ARSKView {
                return true
            }
        }
        return false
    }
}
