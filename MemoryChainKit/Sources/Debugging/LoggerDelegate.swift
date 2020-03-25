//
//  LoggerDelegate.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/11.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//
import AVFoundation
import Foundation

@objc public enum LogLevel:Int {
    case debug = 0
    case verbose = 1
    case info = 2
    case application = 3
    case warning = 4
    case error = 5
    public func name() ->String {
        var readableName:String
        switch self {
        case .debug:
            readableName = "D"
        case .info:
            readableName = "I"
        case .application:
            readableName = "A"
        case .warning:
            readableName = "W"
        case .verbose:
            readableName = "V"
            
        
        case .error:
            readableName = "E"
        }
        return readableName
    }
}

@objc public protocol LoggerDelegate :class{
    @objc func log(_ logLevel:LogLevel,message:String)
}
