//
//  Cacheable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/29.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol Cacheable{
    associatedtype Element
    func set(forKey key:String,
             value:Element?,
             size:vm_size_t) ->Bool
    func set(forKey key:String,
             value:Element?,
             size:vm_size_t,
             completionHandler:@escaping ((_ key:String, _ isFinished:Bool)->Void))
    
    func object(ForKey key:String) ->Element?
    func object(forKey key:String,
                completionHandler:@escaping ((_ key:String,
                                              _ value:Element?)->Void))
    func isExistsObject(forKey key:String)->Bool
        func isExistsObject(forKey key:String,completionHandler:@escaping((_ key:String,_ contain:Bool) -> Void))
        
        func removeAll()
        func removeAll(completionHandler:@escaping(() -> Void))
        
        func removeObject(forKey key:String)
        func removeObject(forKey key:String,completionHandler:@escaping(() -> Void))
    
}
