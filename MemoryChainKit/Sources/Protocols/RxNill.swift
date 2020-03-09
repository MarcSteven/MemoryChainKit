//
//  RxNill.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public protocol OptionalType {
    associatedtype Wrapped
    var optional:Wrapped? { get }
}

