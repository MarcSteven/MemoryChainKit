//
//  Data+JSON.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Data {
    // serialize data into a JSON Object
    func toJSON() throws ->Any? {
        var json:Any?
        do {
            json = try JSONSerialization.jsonObject(with: self, options: [])
            
        }catch {
            throw ParsingError.failed
        }
        return json
    }
}
