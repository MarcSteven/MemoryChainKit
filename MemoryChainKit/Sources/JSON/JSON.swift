//
//  JSON.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public protocol JSONSerializable {
    //JSON Representation
    var json:JSON {get}
    
}
public protocol JSONDeserializable {
//Initialize with a json representation
    init(json:JSON) throws
}
