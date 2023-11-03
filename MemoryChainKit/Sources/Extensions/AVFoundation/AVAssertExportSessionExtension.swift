//
//  AVAssertExportSessionExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import AVFoundation

public extension AVAssetExportSession {
    func compressVideo(_ inputURL:URL,
                       outputURL:URL,
                       completionHandler:@escaping (_ exportSession:AVAssetExportSession?)->Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetLowQuality) else {
            completionHandler(nil)
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously {
            completionHandler(exportSession)
        }
    }
}
