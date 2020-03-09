//
//  CoreDataError.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/22.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


/// CoreData Error
///
/// - saveFailed: save failed
/// - deleteFailed: failed to delete 
public  enum CoreDataError:Error {
    case saveFailed(Error)
    case deleteFailed(Error)
}
