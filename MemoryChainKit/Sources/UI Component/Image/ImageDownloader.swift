//
//  ImageDownloader.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import SDWebImage

extension ImageSourceType.CacheType {
    fileprivate init(_ cacheType:SDImageCacheType) {
        switch cacheType {
        case .none:
            self = .none
        case .disk:
            self = .disk
        case .memory:
            self = .memory
        default:
            fatalError("unknown case detected\(cacheType)")
        }
    }
}

final class ImageDownloader {
    typealias CancelToken = () ->Void
    
    /// Downloads the image at the given URL, if not present in cache or return the cached version otherwise.
    static func load(url: URL, completion: @escaping (_ image: UIImage?, _ data: Data?, _ error: Error?, _ finished: Bool, _ cacheType: ImageSourceType.CacheType) -> Void) -> CancelToken? {
        let token = SDWebImageManager.shared.loadImage(
            with: url,
            options: [.avoidAutoSetImage],
            progress: nil
        ) { image, data, error, cacheType, finished, url in
            completion(image, data, error, finished, .init(cacheType))
        }

        return token?.cancel
    }

    /// Downloads the image from the given url.
    static func download(url: URL, completion: @escaping (_ image: UIImage?, _ data: Data?, _ error: Error?, _ finished: Bool) -> Void) {
        SDWebImageDownloader.shared.downloadImage(
            with: url,
            options: [],
            progress: nil
        ) { image, data, error, finished in
            completion(image, data, error, finished)
        }
    }

    static func removeCache() {
        let imageCache = SDImageCache.shared
        imageCache.clearMemory()
        imageCache.clearDisk(onCompletion: nil)
        imageCache.deleteOldFiles(completionBlock: nil)
        
    }
}
