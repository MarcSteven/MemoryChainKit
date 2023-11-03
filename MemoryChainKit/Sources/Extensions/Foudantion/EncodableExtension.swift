//
//  EncodableExtension.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/12/22.
//  Copyright © 2021 Marc Steven(https://https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public extension Encodable {
    var dictionaryRepresentation:[String:Any]? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap{$0 as? [String :Any]}
    }
}
