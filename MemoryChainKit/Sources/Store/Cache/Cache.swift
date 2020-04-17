//
//  Cache.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation



public protocol Cache {
    associatedtype Element
    func get(key:String,
             completion:@escaping(Element?) ->Void)
    func set(key:String,
             value:Element,
             completion:(()->Void)?)
    func remove(key:String,
                completion:(()->Void)?)
    func removeAll(completion:(()->Void)?)
}
