//
//  RouteType.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

extension Router {
    public enum RouteType {
        case viewController(UIViewController)

        case custom((UINavigationController) -> Void)

        public static var custom: RouteType {
            custom { _ in }
        }
    }
}
