//
//  UIView+LifeCycleHelper.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/14.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol Observer {
    func remove()
}

public extension UIViewController {
    @discardableResult
    func onViewWillAppear(run callback:@escaping () ->Void) ->Observer {
        return ViewControllerLifecycleObserver(parent: self, viewWillAppearCallback: callback)
    }
    @discardableResult
    func onViewDidAppear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewDidAppearCallback: callback
        )
    }
    
    @discardableResult
    func onViewWillDisappear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewWillDisappearCallback: callback
        )
    }
    
    @discardableResult
    func onViewDidDisappear(run callback: @escaping () -> Void) -> Observer {
        return ViewControllerLifecycleObserver(
            parent: self,
            viewDidDisappearCallback: callback
        )
    }
}
private class ViewControllerLifecycleObserver:UIViewController,Observer {
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    private var viewWillAppearCallback:(()->Void)? = nil
   
    private var viewDidAppearCallback:(()->Void)? = nil
    private var viewWillDisappearCallback:(()->Void)? = nil
    private var viewDidDisappearCallback:(()->Void)? = nil
    convenience init(
        parent:UIViewController,
        viewWillAppearCallback:(()->Void)? = nil,
        viewDidAppearCallback:(()->Void)? = nil,
        viewWillDisappearCallback:(()->Void)? = nil,
        viewDidDisappearCallback:(()->Void)? = nil
        ) {
        self.init()
        add(to: parent)
        self.viewWillAppearCallback = viewWillAppearCallback
        self.viewDidAppearCallback = viewDidAppearCallback
        self.viewWillDisappearCallback = viewWillDisappearCallback
        self.viewDidDisappearCallback = viewDidDisappearCallback
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillDisappearCallback?()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearCallback?()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearCallback?()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewDidDisappearCallback?()
    }
    private func add(to parent:UIViewController) {
        parent.addChild(self)
        view.isHidden = true
        parent.view.addSubview(view)
        didMove(toParent: parent)
    }
}
public extension UIViewController {
    var safeTopAnchor:NSLayoutYAxisAnchor {
        return view.safeAreaLayoutGuide.topAnchor
    }
    var safeBottomAnchor:NSLayoutYAxisAnchor {
        return view.safeAreaLayoutGuide.bottomAnchor
    }
    var safeTrailingAnchor:NSLayoutXAxisAnchor {
        return view.safeAreaLayoutGuide.trailingAnchor
    }
    var safeAreaInsets:UIEdgeInsets {
        return view.safeAreaInsets
    }
}
