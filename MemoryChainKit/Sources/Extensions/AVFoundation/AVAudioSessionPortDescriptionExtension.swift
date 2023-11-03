//
//  AVAudioSessionPortDescriptionExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import AVFoundation



public extension AVAudioSessionPortDescription {
    
    var isHeadphones: Bool {
        return portType == AVAudioSession.Port.headphones  ||  portType == AVAudioSession.Port.headsetMic
    }
    
    var isBluetooth: Bool {
        return portType == AVAudioSession.Port.bluetoothHFP || portType == AVAudioSession.Port.bluetoothA2DP || portType == AVAudioSession.Port.bluetoothLE
    }
    
    var isCarAudio: Bool {
        return portType == AVAudioSession.Port.carAudio
    }
    
    var isSpeaker: Bool {
        return portType == AVAudioSession.Port.builtInSpeaker
    }
    
    var isBuiltInMic: Bool {
        return portType == AVAudioSession.Port.builtInMic
    }
    
    var isReceiver: Bool {
        return portType == AVAudioSession.Port.builtInReceiver
    }
}
