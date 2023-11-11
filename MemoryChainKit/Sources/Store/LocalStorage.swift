//
//  LocalStorage.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/9/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public protocol LocalStorage:AnyObject {
    var isLoggedIn:Bool { get }
    func clear()
}
