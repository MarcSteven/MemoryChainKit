//
//  NSManagedObjectContext+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/29.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import CoreData


public extension NSManagedObjectContext {
    func save(_ callback:@escaping (CoreDataError?) ->Void = {_  in}) {
        if !self.hasChanges {
            callback(nil)
        }
        //async save
        self.performAndWait {
            do {
                try self.save()
                // if there is a parentContext,save that one
                if let parentContext = self.parent {
                    parentContext.save(callback)
                    return
                }
                callback(nil)
            }catch (let error ) {
                callback(CoreDataError.saveFailed(error))
            }
        }
    }
}
