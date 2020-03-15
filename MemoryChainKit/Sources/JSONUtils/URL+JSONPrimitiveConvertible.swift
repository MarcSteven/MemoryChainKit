//
//  URL+JSONPrimitiveConvertible.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

extension URL:JSONPrimitiveConvertible {
   
    
    
    ///Creates a url from a string
    public static func from(jsonValue: String) -> URL? {
        return URL(string: jsonValue)
    }
}
