//
//  Result.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/15.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

/** Result is an enum that will be sent back within the response
 It has two states: success and failure
 if success, it will contain the desire avlue,or it will throw the error
 */


public enum Result<Value> {
    case success(Value)
    case failure(MemoryChainError)
    
    public var value:Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
     
        }
    }
    public var error:MemoryChainError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
       
        }
    }
/** Map function, that will allow you to apply a function to a value is the result is a success*/
    public func map<U>(_ f:((Value)->U))->Result<U> {
        switch self {
        case .success(let value):
        
            return .success(f(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    /** FlatMap to chain different results*/
    public func flatMap<U>(_ f:(Value)->Result<U>) ->Result<U> {
        switch self {
        case .success(let value):
            return f(value)
        case .failure(let error):
            return .failure(error)
        
        }
    }
}
