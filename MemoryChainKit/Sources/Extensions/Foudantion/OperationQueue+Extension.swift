//
//  OperationQueue+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/24.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public extension OperationQueue {
    convenience init(qualityOfService:QualityOfService,
                     maxConcurrentOperationCount:Int = OperationQueue.defaultMaxConcurrentOperationCount,
                     name:String? = nil,
                     underlyingQueue:DispatchQueue? = nil,
                     startSuspended:Bool = false) {
        self.init()
        self.qualityOfService = qualityOfService
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
        self.underlyingQueue = underlyingQueue
        self.name = name
        self.isSuspended = startSuspended
        
    }
}
