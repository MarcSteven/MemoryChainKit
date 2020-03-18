//
//  LoggerUtils.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/11.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
open class LoggerUtils {
    private var logger:LoggerDelegate?
    init(_ logger: LoggerDelegate?) {
        self.logger = logger
    }
    
    func d(_ message: String) {
        
        
        logger?.log(.debug, message: message)
    }
    
    func v(_ message: String) {
        logger?.log(.verbose, message: message)
    }
    
    func i(_ message: String) {
        logger?.log(.info, message: message)
    }
    
    func a(_ message: String) {
        logger?.log(.application, message: message)
    }
    
    func w(_ message: String) {
        logger?.log(.warning, message: message)
    }
    
    func e(_ message: String) {
        logger?.log(.error, message: message)
    }
    
    func w(_ error: Error) {
        logger?.log(.warning, message: "Error \((error as NSError).code): \(error.localizedDescription)")
    }
    
    func e(_ error: Error) {
        logger?.log(.error, message: "Error \((error as NSError).code): \(error.localizedDescription)")
    }
}
