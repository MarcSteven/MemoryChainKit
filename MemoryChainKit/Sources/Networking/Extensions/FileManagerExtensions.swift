//
//  FileManagerExtensions.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation




extension FileManager {
    enum FileManagerError:Error {
        case relativeDirectoryNotFound,pathNotFound,onlyDirectoryCreationSupported
    }
    
}
public extension FileManager {
    
    func removeAllCache() throws {
        try urls(for: .cachesDirectory, in: .userDomainMask).forEach {
            directory in
            try removeItem(at: directory)
        }
    }
    func exists(at url: URL) -> Bool {
        let path = url.path

        return fileExists(atPath: path)
    }

    func remove(at url: URL) throws {
        let path = url.path
        guard FileManager.default.isDeletableFile(atPath: url.path) else { return }

        try FileManager.default.removeItem(atPath: path)
    }
}
