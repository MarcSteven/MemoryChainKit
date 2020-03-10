//
//  Bundle+Helpers.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

//MARK: - properties 
extension Bundle {
    var versionNumber:String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    
    }
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var buildNumberInt: Int {
        return Int(Bundle.main.buildNumber ?? "-1") ?? -1
    }
    
    var fullVersion: String {
        let versionNumber = Bundle.main.versionNumber ?? ""
        let buildNumber = Bundle.main.buildNumber ?? ""
        return "\(versionNumber) (\(buildNumber))"
    }
}

    var isDebug: Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}
