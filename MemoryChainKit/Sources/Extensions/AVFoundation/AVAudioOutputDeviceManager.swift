//
//  AVAudioOutputDeviceManager.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import UIKit
import  AVFoundation



@objc enum AudioRoute:Int {
    case headPhones,speaker,bluetooth,carAudio,receiver,none
}
@objc enum ScreenType:Int {
    case onGoingGroupCall,audioCall,screenShare,videoCall,netStreamLive
}

@objc class AudioOutputDeviceManager: NSObject {
    @objc static let shared = AudioOutputDeviceManager()
    var isSpeaker = false
    private override init() {
        super.init()
    }
    
    @objc  func getCurrentPortType() -> AVAudioSession.Port.RawValue? {
        let session = AVAudioSession.sharedInstance()
        
        if let portDescription =  session.currentRoute.outputs.first {
            return portDescription.portType.rawValue
        }
        return nil
    }
    
    @objc func getCurrentAudioRoute () -> AudioRoute {
        let session = AVAudioSession.sharedInstance()
        guard   let portDiscription = session.currentRoute.outputs.first else {return .none}
        if portDiscription.portType  == .builtInSpeaker {
            return .speaker
        }
        if portDiscription.portType  == .bluetoothA2DP || portDiscription.portType  == .bluetoothLE || portDiscription.portType  == .bluetoothHFP {
            return .bluetooth
        }
        if portDiscription.portType  == .headsetMic ||  portDiscription.portType == .headphones || portDiscription.portType == .builtInMic {
            return .headPhones
        }
        if portDiscription.portType == .builtInReceiver {
            return .receiver
        }
        if portDiscription.portType  == .carAudio {
            return .carAudio
        }
        return .none
    }
    
    @objc func isHeadPhoneAvailable() -> Bool {
        guard let availableInputs = AVAudioSession.sharedInstance().availableInputs else {return false}
        for inputDevice in availableInputs {
            if inputDevice.portType == .headsetMic  || inputDevice.portType == .headphones {
                return true
            }
        }
        return false
    }
    @objc func isInbuiltMicAvailable() -> Bool {
        guard let availableInputs = AVAudioSession.sharedInstance().availableInputs else {return false}
        for inputDevice in availableInputs {
            if inputDevice.portType == .builtInReceiver  || inputDevice.portType == .builtInMic {
                return true
            }
        }
        return false
    }
    
    @objc func isDeviceListRequired()-> Bool {
        guard let deviceList = AVAudioSession.sharedInstance().availableInputs else { return false }
        
        if deviceList.count == 2  {
            if isHeadPhoneAvailable() {
                if isInbuiltMicAvailable() {
                    return false
                }
            } else {
                return true
            }
        } else if deviceList.count == 1 {
            
            if !isHeadPhoneAvailable() && !isInbuiltMicAvailable() {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
        return false
    }
    
    @objc func listOfAvailableDevices(controller:UIViewController,speakerButton: UIButton)  {
        AVAudioSession.sharedInstance().ChangeAudioOutput(controller, speakerButton)
    }
    
    @objc func forceOutputPortToSpeaker() {
        
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error turning on speaker: \(error.localizedDescription)")
        }
        isSpeaker = true
    }
}


