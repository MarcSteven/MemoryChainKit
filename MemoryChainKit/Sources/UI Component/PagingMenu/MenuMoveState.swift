//
//  MenuMoveState.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/30.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public enum MenuMoveState {
    case willMoveController(to: UIViewController, from: UIViewController)
    case didMoveController(to: UIViewController, from: UIViewController)
    case willMoveItem(to: MenuItemView, from: MenuItemView)
    case didMoveItem(to: MenuItemView, from: MenuItemView)
    case didScrollStart
    case didScrollEnd
}
