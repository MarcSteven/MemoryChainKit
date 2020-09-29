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
public extension FileManager {
    func getValueForExtendedFileAttributeNamed(_ attributeName: String, forFileAtPath path: String) -> String? {
        let name = (attributeName as NSString).utf8String
        let path = (path as NSString).fileSystemRepresentation

        let bufferLength = getxattr(path, name, nil, 0, 0, 0)

        guard bufferLength != -1, let buffer = malloc(bufferLength) else {
            return nil
        }

        let readLen = getxattr(path, name, buffer, bufferLength, 0, 0)
        return String(bytesNoCopy: buffer, length: readLen, encoding: .utf8, freeWhenDone: true)
    }
}

public extension FileManager {
    func setValue(_ value: String, forExtendedFileAttributeNamed attributeName: String, forFileAtPath path: String) {
        let attributeNamePointer = (attributeName as NSString).utf8String
        let pathPointer = (path as NSString).fileSystemRepresentation
        guard let valuePointer = (value as NSString).utf8String else {
            assert(false, "unable to get value pointer from \(value)")
            return
        }

        let result = setxattr(pathPointer, attributeNamePointer, valuePointer, strlen(valuePointer), 0, 0)
        assert(result != -1)
    }
}
