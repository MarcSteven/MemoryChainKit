//
//  SingleValueEncodingContainer.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/8.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
public protocol SingleValueEncodingContainer {
    
    var codingPath:[CodingKey] {get}
    mutating func encodeNil() throws
    mutating func encode(_ value:Bool) throws
    mutating func encode(_ value:Int) throws
    mutating func encode(_ value:Int8) throws
    mutating func encode(_ value:Int16) throws
    mutating func encode(_ value:Int32) throws
    mutating func encode(_ value:Int64) throws
    mutating func encode(_ value:String) throws
    mutating func encode(_ value:Float) throws
    mutating func encode(_ value:Double) throws
    mutating func encode<T:Encodable>(_ value:T) throws
    
}
