//
//  Router.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
/** class to deal with navigation */
public class Router {
    private weak var navigationController: UINavigationController?
    private var routeHandlers: [String: Any] = [:]

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public func register<T: Routerable>(_ handler: @autoclosure () -> T) -> T {
        let key = name(of: T.self)

        guard let existingHandler = routeHandlers[key] as? T else {
            let handler = handler()
            handler._setNavigationController(navigationController)
            routeHandlers[key] = handler
            return handler
        }

        return existingHandler
    }
}
