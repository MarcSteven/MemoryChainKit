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


public extension FileManager {

    /// This method calculates the accumulated size of a directory on the volume in bytes.
    ///
    /// As there's no simple way to get this information from the file system it has to crawl the entire hierarchy,
    /// accumulating the overall sum on the way. The resulting value is roughly equivalent with the amount of bytes
    /// that would become available on the volume if the directory would be deleted.
    ///
    /// - note: There are a couple of oddities that are not taken into account (like symbolic links, meta data of
    /// directories, hard links, ...). Original code can be found here: https://gist.github.com/NikolaiRuhe/eeb135d20c84a7097516
    ///
    func allocatedSizeOf(directoryURL: URL) throws -> Int64 {

        // We'll sum up content size here:
        var accumulatedSize = Int64(0)

        // prefetching some properties during traversal will speed up things a bit.
        let prefetchedProperties = [
            URLResourceKey.isRegularFileKey,
            URLResourceKey.fileAllocatedSizeKey,
            URLResourceKey.totalFileAllocatedSizeKey,
            ]

        // The error handler simply signals errors to outside code.
        var errorDidOccur: Error?
        let errorHandler: (URL, Error) -> Bool = { _, error in
            errorDidOccur = error
            return false
        }


        // We have to enumerate all directory contents, including subdirectories.
        guard let enumerator = enumerator(at: directoryURL,
                                         includingPropertiesForKeys: prefetchedProperties,
                                         options: DirectoryEnumerationOptions(),
                                         errorHandler: errorHandler) else {
                                            throw NSError(domain: "", code: 0, userInfo: nil)
        }

        // Start the traversal:
        for item in enumerator {
            let contentItemURL = item as! NSURL
            // Bail out on errors from the errorHandler.
            if let error = errorDidOccur { throw error }

            let resourceValueForKey: (String) throws -> NSNumber? = { key in
                var value: AnyObject?
                try contentItemURL.getResourceValue(&value, forKey: URLResourceKey(rawValue: key))
                return value as? NSNumber
            }

            // Get the type of this item, making sure we only sum up sizes of regular files.
            guard let isRegularFile = try resourceValueForKey(URLResourceKey.isRegularFileKey.rawValue) else {
                preconditionFailure()
            }

            guard isRegularFile.boolValue else {
                continue
            }

            // To get the file's size we first try the most comprehensive value in terms of what the file may use on disk.
            // This includes metadata, compression (on file system level) and block size.
            var fileSize = try resourceValueForKey(URLResourceKey.totalFileAllocatedSizeKey.rawValue)

            // In case the value is unavailable we use the fallback value (excluding meta data and compression)
            // This value should always be available.
            fileSize = try fileSize ?? resourceValueForKey(URLResourceKey.fileAllocatedSizeKey.rawValue)

            guard let size = fileSize else {
                preconditionFailure("huh? NSURLFileAllocatedSizeKey should always return a value")
            }

            // We're good, add up the value.
            accumulatedSize += size.int64Value
        }

        // Bail out on errors from the errorHandler.
        if let error = errorDidOccur { throw error }

        // We finally got it.
        return accumulatedSize
    }
}
