//
//  FileManager+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/11/9.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import Foundation
public enum LocationKind {
    case file
    case folder
}

public extension FileManager {
    func locationExists(at path:String,
                        kind:LocationKind) ->Bool {
        var isFolder:ObjCBool = false
        guard fileExists(atPath: path, isDirectory: &isFolder) else {
            return false
        }
        switch kind {
        case .file:
            return !isFolder.boolValue
        case .folder:
            return isFolder.boolValue
        
        }
    }
}
