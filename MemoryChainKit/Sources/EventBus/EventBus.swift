//
//  EventBus.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


/**
 Class implements mechanism of events bus which is used by TigaseSwift
 to notify about events.
 */
open class EventBus: Logger {
    
    fileprivate var handlersByEvent:[String:[EventHandler]];
    
    private let dispatcher: QueueDispatcher;
    
    public convenience override init() {
        self.init(queueDispatcher: nil);
    }
    
    public init(queueDispatcher: QueueDispatcher?) {
        handlersByEvent = [:];
        self.dispatcher = queueDispatcher ?? QueueDispatcher(label: "eventbus_queue");
        super.init();
    }
    
    /**
     Registeres handler to be notified when events of particular types are fired
     - parameter handler: handler to register
     - parameter for: events on which handler should be notified
     */
    open func register(handler:EventHandler, for events:Event...) {
        register(handler: handler, for: events);
    }
    
    /**
     Registeres handler to be notified when events of particular types are fired
     - parameter handler: handler to register
     - parameter for: events on which handler should be notified
     */
    open func register(handler:EventHandler, for events:[Event]) {
        dispatcher.async {
            for event in events {
                let type = event.type;
                var handlers = self.handlersByEvent[type];
                if handlers == nil {
                    handlers = [EventHandler]();
                }
                if (handlers!.firstIndex(where: { $0 === handler }) == nil) {
                    handlers!.append(handler);
                }
                self.handlersByEvent[type] = handlers;
            }
        }
    }
    
    /**
     Unregisteres handler, so it will not be notified when events of particular types are fired
     - parameter handler: handler to unregister
     - parameter for: events on which handler should not be notified
     */
    open func unregister(handler:EventHandler, for events:Event...) {
        self.unregister(handler: handler, for: events);
    }
    
    /**
     Unregisteres handler, so it will not be notified when events of particular types are fired
     - parameter handler: handler to unregister
     - parameter for: events on which handler should not be notified
     */
    open func unregister(handler:EventHandler, for events:[Event]) {
        dispatcher.async {
            for event in events {
                let type = event.type;
                if var handlers = self.handlersByEvent[type] {
                    if let idx = handlers.firstIndex(where: { $0 === handler }) {
                        handlers.remove(at: idx);
                    }
                    self.handlersByEvent[type] = handlers;
                }
            }
        }
    }
    
    /**
     Fire event on this event bus
     - parameter event: event to fire
     */
    open func fire(_ event:Event) {
        if event is SerialEvent {
            dispatcher.sync {
                let type = event.type;
                if let handlers = self.handlersByEvent[type] {
                    for handler in handlers {
                        handler.handle(event);
                    }
                }
            }
        } else {
            dispatcher.async {
                let type = event.type;
                if let handlers = self.handlersByEvent[type] {
                    for handler in handlers {
                        handler.handle(event);
                    }
                }
            }
        }
    }
}
