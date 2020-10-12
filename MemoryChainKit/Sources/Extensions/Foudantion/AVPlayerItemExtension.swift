//
//  AVPlayerItemExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/12.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import AVFoundation


public extension AVPlayerItem {
    /// Initializes an AVPlayerItem with local resource referenced filename.
    ///
    /// - Parameters:
    ///   - filename: The local filename.
    ///   - bundle: The bundle containing the specified filename. If you specify `nil`,
    ///   this method looks in the main bundle of the current application. The default value is `nil`.
    /// - Returns: An instance of AVPlayerItem.
     convenience init?(filename: String, bundle: Bundle? = nil) {
        let name = filename.lastPathComponent.deletingPathExtension
        let ext = filename.pathExtension
        let bundle = bundle ?? Bundle.main

        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            return nil
        }

        self.init(url: url)
    }

    /// Automatically detect and load the asset from local or a remote url.
     convenience init?(remoteOrLocalName: String) {
        guard let url = URL(string: remoteOrLocalName), url.host != nil else {
            self.init(filename: remoteOrLocalName)
            return
        }

        self.init(url: url)
    }
}

