//
//  SceneCoordinatorType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/10.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import RxSwift

public protocol SceneCoordinatorType {
    init(window:UIWindow)
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void>
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
}