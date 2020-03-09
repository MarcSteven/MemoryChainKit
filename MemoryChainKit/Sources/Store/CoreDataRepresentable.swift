//
//  CoreDataRepresentable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/29.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol CoreDataRepresentable {
    associatedtype CoreDataBaseType
    var coreDataValue:CoreDataBaseType {get}
    init?(coreDataValue:CoreDataBaseType)
    static var coreDataCallBack:Self {get}
}
public extension RawRepresentable where Self:CoreDataRepresentable {
    var coreDataValue:Self.RawValue {
        return self.rawValue
    }
    init?(coreDataValue:CoreDataBaseType) {
        self.init(rawValue: coreDataValue as! Self.RawValue)
    }
}
