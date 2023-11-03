//
//  MSOperationSafeGuard.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/10.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

extension OperationQueue {
    
}
open class  MSOperationSafeGuard:NSObject {
    private let MSOperationSafetyGuardRemoveOperationAfterFinishedDelay: TimeInterval = 2.0
    private let MSOperationSafetyGuardCheckForAlreadyFinishedOperationDelay: TimeInterval = 1.0


    private var queue:DispatchQueue?
    private var _operations:Set<AnyHashable>?
    
    convenience override init() {
        
        self.init()
        self._operations = Set<AnyHashable>()
        self.queue = DispatchQueue(label: "NSOperationQueue.ms.safety")
        
    }
    func add(_ op:Operation) {
        
    }
   public  static let operationSafetyGuard:MSOperationSafeGuard? = {
        var sGuard = MSOperationSafeGuard()
        return sGuard
    }()
    func operations() ->Set<AnyHashable>? {
        var operations: Set<AnyHashable>?
        queue?.sync(execute: {
            operations = self.operations()
        })
        return operations!
    }
    func addOperation(_ op:Operation) {
        if !op.isAsynchronous || op.isFinished {
            return
        }
        queue?.async(execute: {
            //self.operations()?.insert(op)
            
            op.addObserver(self, forKeyPath: "isFinished", options: [.new,.initial], context: nil)
            //There are race conditions where the isFinished kvo may never be observed
            //Use this async check to weed out any early finishing operations that we didn't observe finishing
            self.queue?.asyncAfter(deadline: DispatchTime.now() + Double(Int64(self.MSOperationSafetyGuardRemoveOperationAfterFinishedDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                if op.isFinished {
                    self.observeValue(forKeyPath: "isFinished", of: op, change: [NSKeyValueChangeKey.newKey:NSNumber(value: true)], context: nil)
                }
            })
        })
    }
    func _ms_background_remove(_ op:Operation?) {
        if let op = op {
            if (_operations?.contains(op))! {
                op.removeObserver(self,forKeyPath:"isFinished")
                _operations?.removeAll()
                
                
            }
        }
    }
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "isFinished") && (change?[NSKeyValueChangeKey.newKey] as? NSNumber)?.boolValue ?? false {
            let op = object as? Operation
            queue?.asyncAfter(deadline: DispatchTime.now() + Double(Int64(MSOperationSafetyGuardRemoveOperationAfterFinishedDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self._ms_background_remove(op)
            })
        }
    }

}
