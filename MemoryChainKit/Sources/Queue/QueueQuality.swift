//
//  QueueQuality.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public enum QueueQuality {
    case `default`,background,userInitiated,utility,userInteractive,unspecified
    static func systemOOS(_ quality:QueueQuality) ->qos_class_t {
        switch quality {
        case .background:
            return QOS_CLASS_BACKGROUND
        case .utility:
            return QOS_CLASS_UTILITY
        case .unspecified:
            return QOS_CLASS_UNSPECIFIED
        case .userInitiated:
            return QOS_CLASS_USER_INITIATED
        case .default:
            return QOS_CLASS_DEFAULT
        case .userInteractive:
            return QOS_CLASS_USER_INTERACTIVE
        
        }
    }
    
}

extension QueueQuality:CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return "use default service"
        case .background:
            return "use background serive"
        case .unspecified:
            return "use unspecified service"
        case .userInteractive:
            return "use userInteractive"
        case .userInitiated:
            return "use userInitiate"
        case .utility:
            return "use utility service"
        
        }
    }
}
