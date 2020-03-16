//
//  APIClient.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

open class APIClient {
    static let domain = "com.memoriesus.apiClient"
    fileprivate let baseURL:String
    var falseRequests = [[HTTPMethod:FalseRequest]()]
    var token:String?
    var authorizationHeaderValue:String?
    var authorizationHeaderKey = "Authorization"
    fileprivate var configuration:URLSessionConfiguration
    var cache:NSCache<AnyObject,AnyObject>
    public var isSynchronous = false
    
    public var isErrorLoggingEnable = true
     let boundary = String(format: "com.memoriesus.apiClient.%08x%08x", arc4random(), arc4random())
    lazy var session:URLSession = {
        URLSession(configuration: self.configuration)
    }()
    public init(baseURL:String = "",
                configuration:URLSessionConfiguration = .default,
                cache:NSCache<AnyObject,AnyObject>? = nil) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.cache = cache ?? NSCache()
    }
    func setAuthorizationHeader(userName:String,
                                password:String) {
        let credentialString = "\(userName):\(password)"
        if let credentialData = credentialString.data(using: .utf8) {
            let base64Credential = credentialData.base64EncodedString(options: [])
            let authString = "Basic\(base64Credential)"
            authorizationHeaderKey = "Authorization"
            authorizationHeaderValue = authString
        }
    }
    func setAuthorizationHeader(_ token:String) {
        self.token = token
    }
    public var headerFields:[String:String]?
    public func setAuthorizationHeader(headerKey:String = "Authorization",
                                       headerValue:String) {
        authorizationHeaderKey = headerKey
        authorizationHeaderValue = headerValue
    }
    //Closure used to intercept requests that return with a 403/401
    public var unauthorizedRequestCompletionHandler:(()->Void)?
    
    public func composedURL(with path:String) throws ->URL {
        let encodedPath = path.encodeUTF8() ?? path
        guard let url = URL(string: baseURL + encodedPath) else {
            throw NSError(domain: APIClient.domain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Couldn't create a url using baseURL: \(baseURL) and encodedPath: \(encodedPath)"])
        }
        return url

    }
    /// Returns the URL used to store a resource for a certain path. Useful to find where a download image is located.
    ///
    /// - Parameters:
    ///   - path: The path used to download the resource.
    ///   - cacheName: The alias to be used for storing the resource, if a cache name is provided, this will be used instead of the path.
    /// - Returns: A URL where a resource has been stored.
    /// - Throws: An error if the URL couldn't be created.
    public func destinationURL(for path: String, cacheName: String? = nil) throws -> URL {
        let normalizedCacheName = cacheName?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var resourcesPath: String
        if let normalizedCacheName = normalizedCacheName {
            resourcesPath = normalizedCacheName
        } else {
            let url = try composedURL(with: path)
            resourcesPath = url.absoluteString
        }

        let normalizedResourcesPath = resourcesPath.replacingOccurrences(of: "/", with: "-")
        let folderPath = APIClient.domain
        let finalPath = "\(folderPath)/\(normalizedResourcesPath)"

        if let url = URL(string: finalPath) {
            let directory = FileManager.SearchPathDirectory.cachesDirectory
            if let cachesURL = FileManager.default.urls(for: directory, in: .userDomainMask).first {
                let folderURL = cachesURL.appendingPathComponent(URL(string: folderPath)!.absoluteString)

                if FileManager.default.exists(at: folderURL) == false {
                    try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
                }

                let destinationURL = cachesURL.appendingPathComponent(url.absoluteString)

                return destinationURL
            } else {
                throw NSError(domain: APIClient.domain, code: 9999, userInfo: [NSLocalizedDescriptionKey: "Couldn't normalize url"])
            }
        } else {
            throw NSError(domain: APIClient.domain, code: 9999, userInfo: [NSLocalizedDescriptionKey: "Couldn't create a url using replacedPath: \(finalPath)"])
        }
    }

    /// Splits a url in base url and relative path.
    ///
    /// - Parameter path: The full url to be splitted.
    /// - Returns: A base url and a relative path.
    public static func splitBaseURLAndRelativePath(for path: String) -> (baseURL: String, relativePath: String) {
        guard let encodedPath = path.encodeUTF8() else { fatalError("Couldn't encode path to UTF8: \(path)") }
        guard let url = URL(string: encodedPath) else { fatalError("Path \(encodedPath) can't be converted to url") }
        guard let baseURLWithDash = URL(string: "/", relativeTo: url)?.absoluteURL.absoluteString else { fatalError("Can't find absolute url of url: \(url)") }
        let index = baseURLWithDash.index(before: baseURLWithDash.endIndex)
        let baseURL = String(baseURLWithDash[..<index])
        let relativePath = path.replacingOccurrences(of: baseURL, with: "")

        return (baseURL, relativePath)
    }

    /// Cancels the request that matches the requestID.
    ///
    /// - Parameter requestID: The ID of the request to be cancelled.
    public func cancel(_ requestID: String) {
        let semaphore = DispatchSemaphore(value: 0)
        session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            var tasks = [URLSessionTask]()
            tasks.append(contentsOf: dataTasks as [URLSessionTask])
            tasks.append(contentsOf: uploadTasks as [URLSessionTask])
            tasks.append(contentsOf: downloadTasks as [URLSessionTask])

            for task in tasks {
                if task.taskDescription == requestID {
                    task.cancel()
                    break
                }
            }

            semaphore.signal()
        }

        _ = semaphore.wait(timeout: DispatchTime.now() + 60.0)
    }

    /// Cancels all the current requests.
    public func cancelAllRequests() {
        let semaphore = DispatchSemaphore(value: 0)
        session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            for sessionTask in dataTasks {
                sessionTask.cancel()
            }
            for sessionTask in downloadTasks {
                sessionTask.cancel()
            }
            for sessionTask in uploadTasks {
                sessionTask.cancel()
            }

            semaphore.signal()
        }

        _ = semaphore.wait(timeout: DispatchTime.now() + 60.0)
    }

    /// Removes the stored credentials and cached data.
    public func reset() {
        cache.removeAllObjects()
        falseRequests.removeAll()
        token = nil
        headerFields = nil
        authorizationHeaderKey = "Authorization"
        authorizationHeaderValue = nil
        
        APIClient.deleteCachedFiles()
    }

    /// Deletes the downloaded/cached files.
    public static func deleteCachedFiles() {
        let directory = FileManager.SearchPathDirectory.cachesDirectory
        if let cachesURL = FileManager.default.urls(for: directory, in: .userDomainMask).first {
            let folderURL = cachesURL.appendingPathComponent(URL(string: APIClient.domain)!.absoluteString)
            if FileManager.default.exists(at: folderURL) {
                _ = try? FileManager.default.remove(at: folderURL)
            }
        }
    }
}
