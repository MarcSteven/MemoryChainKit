//
//  AVPlayerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/12.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import AVFoundation
import ObjectiveC


public extension AVPlayer {
    var isPlaying:Bool {
        return timeControlStatus == .playing
    }
    var isPaused:Bool {
        return timeControlStatus == .paused
    }
    private struct AssociatedKey {
        static var playerRepeat = "playerRepeat"
    }

    /// Indicates whether to repeat playback of the current item.
     var `repeat`: Bool {
        get { associatedObject(&AssociatedKey.playerRepeat, default: false) }
        set {
            guard newValue != `repeat` else { return }
            setAssociatedObject(&AssociatedKey.playerRepeat, value: newValue)

            guard newValue else {
                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: currentItem)
                return
            }

            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: currentItem, queue: nil) { [weak self] notification in
                guard let strongSelf = self, let currentItem = notification.object as? AVPlayerItem else {
                    return
                }

                strongSelf.actionAtItemEnd = .none
                currentItem.seek(to: .zero) { [weak self] _ in
                    self?.play()
                }
            }
        }
    }
    func currentTime(_ block: @escaping (_ seconds: Int, _ formattedTime: String) -> Void) -> Any {
        let interval = CMTime(value: 1, timescale: 1)

        return addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let strongSelf = self else { return }
            let currentTime = strongSelf.currentTime()
            let normalizedTime = Double(currentTime.value) / Double(currentTime.timescale)
            block(Int(normalizedTime), strongSelf.format(seconds: Int(normalizedTime)))
        }
    }

    private func format(seconds: Int) -> String {
        let sec = seconds % 60
        let min = seconds / 60
        let hrs = seconds / 3600

        if hrs == 0 {
            return String(format: "%02d:%02d", min, sec)
        }

        return String(format: "%02d:%02d:%02d", hrs, min, sec)
    }

    /// Initializes an AVPlayer that automatically detect and load the asset from local or a remote url.
    ///
    /// Implicitly creates an AVPlayerItem. Clients can obtain the AVPlayerItem as it becomes the player's currentItem.
    ///
    /// - Parameter remoteOrLocalName: The local filename from `NSBundle.mainBundle()` or remote url.
    /// - Returns: An instance of AVPlayer.
    convenience init?(remoteOrLocalName: String) {
        guard let playerItem = AVPlayerItem(remoteOrLocalName: remoteOrLocalName) else {
            return nil
        }

        self.init(playerItem: playerItem)
    }

    
}
