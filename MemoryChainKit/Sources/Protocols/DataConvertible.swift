//
//  DataConvertible.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/12.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
public protocol DataConvertible {
    static func +(lhs:Data,rhs:Self) ->Data
    static func +=(lhs:inout Data,rhs:Self)
}

public extension DataConvertible {
    static func + (lhs:Data,rhs:Self) ->Data {
        var value = rhs
        let data = withUnsafePointer(to: &value) { (pointer) -> Data in
            Data(buffer: UnsafeBufferPointer(start: pointer, count: 1))
        }
        return lhs + data
    }
   static func += (lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
}
extension UInt8  : DataConvertible { }
extension UInt16 : DataConvertible { }
extension UInt32 : DataConvertible { }

extension Int    : DataConvertible { }
extension Float  : DataConvertible { }
extension Double : DataConvertible { }

extension String : DataConvertible {
    
    public static func + (lhs: Data, rhs: String) -> Data {
        guard let data = rhs.data(using: .utf8) else { return lhs}
        return lhs + data
    }
    
}

extension Data : DataConvertible {
    
    public static func + (lhs: Data, rhs: Data) -> Data {
        var data = Data()
        data.append(lhs)
        data.append(rhs)
        
        return data
    }
    
}
