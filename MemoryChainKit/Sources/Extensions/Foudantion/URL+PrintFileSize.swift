//
//  URL+PrintFileSize.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/5.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation



//Utility to print file size to console

public extension URL {
    func verboseFileSizeInMemory()-> String {
        let p = self.path
        let attr = try? FileManager.default.attributesOfItem(atPath: p)
        
        if let attr = attr {
            let fileSize = Float(attr[FileAttributeKey.size] as! UInt64) / (1024.0 * 1024.0)
//            print(String(format: "FILE SIZE: %.2f MB", fileSize))
            return String(format: "%.2f MB", fileSize)
        } else {
            return  "0"
        }
    }
}
