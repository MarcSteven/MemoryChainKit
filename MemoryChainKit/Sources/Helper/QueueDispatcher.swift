


//
//  QueueDispatcher.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//


import Foundation

/**
 Helper protocol for classes using internal dispatch queues
 */
public class QueueDispatcher {
    
    struct QueueIdentity {
        let label: String;
    }
    
    private static var usedQueueNames: [String] = [];
    
    private let queueKey: DispatchSpecificKey<QueueIdentity>;
    let queue: DispatchQueue;
    
    private var currentQueueIdentity: QueueIdentity? {
        return DispatchQueue.getSpecific(key: self.queueKey);
    }
    
    private var execOnCurrentQueue: Bool {
        return self.currentQueueIdentity?.label == queue.label;
    }
    
    public init(label prefix: String, attributes: DispatchQueue.Attributes? = nil) {
        let label = "\(prefix) \(UUID().uuidString)";
        self.queue = attributes == nil ? DispatchQueue(label: label) : DispatchQueue(label: label, attributes: attributes!);
        self.queueKey = DispatchSpecificKey<QueueIdentity>();
        self.queue.setSpecific(key: queueKey, value: QueueIdentity(label: queue.label));
    }
    
    open func sync<T>(flags: DispatchWorkItemFlags, execute: () throws -> T) rethrows -> T {
        if (execOnCurrentQueue) {
            return try execute();
        } else {
            return try queue.sync(flags: flags, execute: execute)
        }
    }

    open func sync(flags: DispatchWorkItemFlags, execute: () throws -> Void) rethrows {
        if (execOnCurrentQueue) {
            try execute();
        } else {
            try queue.sync(flags: flags, execute: execute);
        }
    }

    open func sync<T>(execute: () throws -> T) rethrows -> T {
        if (execOnCurrentQueue) {
            return try execute();
        } else {
            return try queue.sync(execute: execute);
        }
    }

    open func sync(execute: () throws -> Void) rethrows {
        if (execOnCurrentQueue) {
            try execute();
        } else {
            try queue.sync(execute: execute);
        }
    }

    open func async(flags: DispatchWorkItemFlags, execute: @escaping ()->Void) {
        queue.async(flags: flags, execute: execute);
    }
    
    open func async(execute: @escaping () -> Void) {
        queue.async(execute: execute);
    }
}
