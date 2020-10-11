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
public extension FileManager {
    
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

extension FileManager {
    /// Returns the first URL for the specified common directory in the user domain.
    open func url(for directory: SearchPathDirectory) -> URL? {
        urls(for: directory, in: .userDomainMask).first
    }
}

extension FileManager {
    public enum Options {
        case none
        /// An option to create url if it does not already exist.
        case createIfNotExists(_ resourceValue: URLResourceValues?)

        public static var createIfNotExists: Self {
            createIfNotExists(nil)
        }
    }

    enum FileManagerError: Error {
        case relativeDirectoryNotFound
        case pathNotFound
        case onlyDirectoryCreationSupported
    }

    /// Returns a `URL` constructed by appending the given path component relative
    /// to the specified directory.
    ///
    /// - Parameters:
    ///   - path: The path component to add.
    ///   - directory: The directory in which the given `path` is constructed.
    ///   - options: The options that are applied to when appending path. See
    ///                 `FileManager.Options` for possible values. The default value is `.none`.
    /// - Returns: Returns a `URL` constructed by appending the given path component
    ///            relative to the specified directory.
    open func appending(path: String, relativeTo directory: SearchPathDirectory, options: Options = .none) throws -> URL {
        guard var directoryUrl = url(for: directory) else {
            throw FileManagerError.relativeDirectoryNotFound
        }

        directoryUrl = directoryUrl.appendingPathComponent(path, isDirectory: true)

        if case .createIfNotExists(let resourceValue) = options {
            try createIfNotExists(directoryUrl, resourceValue: resourceValue)
        }

        if fileExists(atPath: directoryUrl.path) {
            return directoryUrl
        }

        throw FileManagerError.pathNotFound
    }
}

extension FileManager {
    /// Creates the given url if it does not already exist.
    open func createIfNotExists(_ url: URL, resourceValue: URLResourceValues? = nil) throws {
        guard !fileExists(atPath: url.path) else {
            return
        }

        guard url.hasDirectoryPath else {
            throw FileManagerError.onlyDirectoryCreationSupported
        }

        var url = url
        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)

        if let resourceValue = resourceValue {
            try url.setResourceValues(resourceValue)
        }
    }
}

extension FileManager {
    /// Remove all cached data from `cachesDirectory`.
    public func removeAllCache() throws {
        try urls(for: .cachesDirectory, in: .userDomainMask).forEach { directory in
            try removeItem(at: directory)
        }
    }
}

extension FileManager {
    var memoryChainCacheDirectory: URL? {
        var resourceValue = URLResourceValues()
        resourceValue.isExcludedFromBackup = true

        return try? appending(
            path: "com.memorychain",
            relativeTo: .cachesDirectory,
            options: .createIfNotExists(resourceValue)
        )
    }
}
