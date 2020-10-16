//
//  AVAssetExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import AVFoundation

public extension AVAsset {
    func videoDuration(for videoURL:URL) ->Double {
        let asset = AVAsset(url: videoURL)
        let duration = asset.duration
        let durationSeconds = CMTimeGetSeconds(duration)
        return durationSeconds
    }
}
