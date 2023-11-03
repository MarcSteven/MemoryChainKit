//
//  Response.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/15.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


/** The object returned when the request is completed*/

public class Response<Value> {
    public let response:HTTPURLResponse?
    
    /** DATA  contained in the response body*/
    public let data:Data
    public let result:Result<Value>
    
    public init(response:HTTPURLResponse?,
                data:Data,
                result:Result<Value>) {
        self.response = response
        self.data = data
        self.result = result
    }
    
}
