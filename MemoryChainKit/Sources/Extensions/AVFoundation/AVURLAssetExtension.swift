

//Copyright belongs to Marc Steven in 8th Nov, 2023


import AVFoundation
import Foundation

public extension AVURLAsset {
    /// Audio format for  the file in the URL asset
    var audioFormat: AVAudioFormat? {
        // pull the input format out of the audio file...
        if let source = try? AVAudioFile(forReading: url) {
            return source.fileFormat

            // if that fails it might be a video, so check the tracks for audio
        } else {
            let audioTracks = tracks.filter { $0.mediaType == .audio }

            guard !audioTracks.isEmpty else { return nil }

            let formatDescriptions = audioTracks.compactMap {
                $0.formatDescriptions as? [CMFormatDescription]
            }.reduce([], +)

            let audioFormats: [AVAudioFormat] = formatDescriptions.compactMap {
                AVAudioFormat(cmAudioFormatDescription: $0)
            }
            return audioFormats.first
        }
    }
}