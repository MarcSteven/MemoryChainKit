//
//  Configurable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/11.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol Configurable {
    associatedtype ConfiguredType
    func configure(for item:ConfiguredType)
}
