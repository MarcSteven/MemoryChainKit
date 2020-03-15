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
    func save(_ completionHandler:@escaping (CoreDataError?) ->Void = {_  in}) {
        if !self.hasChanges {
            completionHandler(nil)
        }
        //async save
        self.performAndWait {
            do {
                try self.save()
                // if there is a parentContext,save that one
                if let parentContext = self.parent {
                    parentContext.save(completionHandler)
                    return
                }
                completionHandler(nil)
            }catch (let error ) {
                completionHandler(CoreDataError.saveFailed(error))
            }
        }
    }
}
