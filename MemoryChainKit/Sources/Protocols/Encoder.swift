//
//  Encoder.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/8.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol Encoder {
    var codingPath:[CodingKey] {get}
    var userInfo:[CodingUserInfoKey:Any] {get}
    func container<Key:CodingKey>(keyedBy type:Key.Type)->KeyedEncodingContainer<Key>
    func unkeyedContainer() -> UnkeyedEncodingContainer
    func singleValueContainer() ->SingleValueEncodingContainer
    
}
