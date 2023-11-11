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
public extension AVAsset {
    func videoComposition() ->AVMutableVideoComposition? {
        let videoTrack = tracks(withMediaType: .video)[0]
        let composition = AVMutableComposition()
        let videoComposition = AVMutableVideoComposition()
        var videoSize = videoTrack.naturalSize
        let isPortrait = isVideoPortrait()
        if isPortrait {
            videoSize = CGSize(width: videoSize.height, height: videoSize.width)
        }
        composition.naturalSize = videoSize
        videoComposition.renderSize = videoSize
        videoComposition.frameDuration = CMTimeMakeWithSeconds(Float64(1 / videoTrack.nominalFrameRate), preferredTimescale: 600)
        var compositionVideoTrack :AVMutableCompositionTrack?
        compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: duration), of: videoTrack, at: .zero)
        }catch {
            
        }
        var layerInst :AVMutableVideoCompositionLayerInstruction?
        layerInst = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        layerInst?.setTransform(videoTrack.preferredTransform, at: .zero)
        let inst = AVMutableVideoCompositionInstruction()
        inst.timeRange = CMTimeRangeMake(start: .zero, duration: duration)
        inst.layerInstructions = [layerInst].compactMap{$0}
        videoComposition.instructions = [inst]
        return videoComposition
        
    }
    func isVideoPortrait() ->Bool {
        var isPortrait = false
        let tracks = self.tracks(withMediaType: .video)
        if tracks.count  > 0  {
            let videoTrack = tracks[0]
            let t = videoTrack.preferredTransform
            if t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0 {
                isPortrait = true
                
            }
            // PortraitUpsideDown
                   if t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0 {

                       isPortrait = true
                   }
                   // LandscapeRight
                   if t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0 {
                       isPortrait = false
                   }
                   // LandscapeLeft
                   if t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0 {
                       isPortrait = false
                   }
        }
        return isPortrait
    }
}

