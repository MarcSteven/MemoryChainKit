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


import AVFoundation
import CryptoKit

public extension AVAudioPCMBuffer {
    /// Hash useful for testing
    var md5: String {
        var sampleData = Data()

        if let floatChannelData = floatChannelData {
            for frame in 0 ..< frameCapacity {
                for channel in 0 ..< format.channelCount {
                    let sample = floatChannelData[Int(channel)][Int(frame)]

                    withUnsafePointer(to: sample) { ptr in
                        sampleData.append(UnsafeBufferPointer(start: ptr, count: 1))
                    }
                }
            }
        }

        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            let digest = Insecure.MD5.hash(data: sampleData)
            return digest.map { String(format: "%02hhx", $0) }.joined()
        } else {
            // Fallback on earlier versions
            return "Oh well, old version"
        }
    }

    var isSilent: Bool {
        if let floatChannelData = floatChannelData {
            for channel in 0 ..< format.channelCount {
                for frame in 0 ..< frameLength {
                    if floatChannelData[Int(channel)][Int(frame)] != 0.0 {
                        return false
                    }
                }
            }
        }
        return true
    }

    /// Add to an existing buffer
    ///
    /// - Parameter buffer: Buffer to append
    func append(_ buffer: AVAudioPCMBuffer) {
        append(buffer, startingFrame: 0, frameCount: buffer.frameLength)
    }

    /// Add to an existing buffer with specific starting frame and size
    /// - Parameters:
    ///   - buffer: Buffer to append
    ///   - startingFrame: Starting frame location
    ///   - frameCount: Number of frames to append
    func append(_ buffer: AVAudioPCMBuffer,
                startingFrame: AVAudioFramePosition,
                frameCount: AVAudioFrameCount)
    {
        precondition(format == buffer.format,
                     "Format mismatch")
        precondition(startingFrame + AVAudioFramePosition(frameCount) <= AVAudioFramePosition(buffer.frameLength),
                     "Insufficient audio in buffer")
        precondition(frameLength + frameCount <= frameCapacity,
                     "Insufficient space in buffer")

        let dst1 = floatChannelData![0]
        let src1 = buffer.floatChannelData![0]

        memcpy(dst1.advanced(by: stride * Int(frameLength)),
               src1.advanced(by: stride * Int(startingFrame)),
               Int(frameCount) * stride * MemoryLayout<Float>.size)

        let dst2 = floatChannelData![1]
        let src2 = buffer.floatChannelData![1]

        memcpy(dst2.advanced(by: stride * Int(frameLength)),
               src2.advanced(by: stride * Int(startingFrame)),
               Int(frameCount) * stride * MemoryLayout<Float>.size)

        frameLength += frameCount
    }

    /// Copies data from another PCM buffer.  Will copy to the end of the buffer (frameLength), and
    /// increment frameLength. Will not exceed frameCapacity.
    ///
    /// - Parameter buffer: The source buffer that data will be copied from.
    /// - Parameter readOffset: The offset into the source buffer to read from.
    /// - Parameter frames: The number of frames to copy from the source buffer.
    /// - Returns: The number of frames copied.
    @discardableResult func copy(from buffer: AVAudioPCMBuffer,
                                 readOffset: AVAudioFrameCount = 0,
                                 frames: AVAudioFrameCount = 0) -> AVAudioFrameCount
    {
        let remainingCapacity = frameCapacity - frameLength
        if remainingCapacity == 0 {
            Log("AVAudioBuffer copy(from) - no capacity!")
            return 0
        }

        if format != buffer.format {
            Log("AVAudioBuffer copy(from) - formats must match!")
            return 0
        }

        let totalFrames = Int(min(min(frames == 0 ? buffer.frameLength : frames, remainingCapacity),
                                  buffer.frameLength - readOffset))

        if totalFrames <= 0 {
            Log("AVAudioBuffer copy(from) - No frames to copy!")
            return 0
        }

        let frameSize = Int(format.streamDescription.pointee.mBytesPerFrame)
        if let src = buffer.floatChannelData,
           let dst = floatChannelData
        {
            for channel in 0 ..< Int(format.channelCount) {
                memcpy(dst[channel] + Int(frameLength), src[channel] + Int(readOffset), totalFrames * frameSize)
            }
        } else if let src = buffer.int16ChannelData,
                  let dst = int16ChannelData
        {
            for channel in 0 ..< Int(format.channelCount) {
                memcpy(dst[channel] + Int(frameLength), src[channel] + Int(readOffset), totalFrames * frameSize)
            }
        } else if let src = buffer.int32ChannelData,
                  let dst = int32ChannelData
        {
            for channel in 0 ..< Int(format.channelCount) {
                memcpy(dst[channel] + Int(frameLength), src[channel] + Int(readOffset), totalFrames * frameSize)
            }
        } else {
            return 0
        }
        frameLength += AVAudioFrameCount(totalFrames)
        return AVAudioFrameCount(totalFrames)
    }

    /// Copy from a certain point tp the end of the buffer
    /// - Parameter startSample: Point to start copy from
    /// - Returns: an AVAudioPCMBuffer copied from a sample offset to the end of the buffer.
    func copyFrom(startSample: AVAudioFrameCount) -> AVAudioPCMBuffer? {
        guard startSample < frameLength,
              let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameLength - startSample)
        else {
            return nil
        }
        let framesCopied = buffer.copy(from: self, readOffset: startSample)
        return framesCopied > 0 ? buffer : nil
    }

    /// Copy from the beginner of a buffer to a certain number of frames
    /// - Parameter count: Length of frames to copy
    /// - Returns: an AVAudioPCMBuffer copied from the start of the buffer to the specified endSample.
    func copyTo(count: AVAudioFrameCount) -> AVAudioPCMBuffer? {
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: count) else {
            return nil
        }
        let framesCopied = buffer.copy(from: self, readOffset: 0, frames: min(count, frameLength))
        return framesCopied > 0 ? buffer : nil
    }

    /// Extract a portion of the buffer
    ///
    /// - Parameter startTime: The time of the in point of the extraction
    /// - Parameter endTime: The time of the out point
    /// - Returns: A new edited AVAudioPCMBuffer
    func extract(from startTime: TimeInterval,
                 to endTime: TimeInterval) -> AVAudioPCMBuffer?
    {
        let sampleRate = format.sampleRate
        let startSample = AVAudioFrameCount(startTime * sampleRate)
        var endSample = AVAudioFrameCount(endTime * sampleRate)

        if endSample == 0 {
            endSample = frameLength
        }

        let frameCapacity = endSample - startSample

        guard frameCapacity > 0 else {
            Log("startSample must be before endSample", type: .error)
            return nil
        }

        guard let editedBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCapacity) else {
            Log("Failed to create edited buffer", type: .error)
            return nil
        }

        guard editedBuffer.copy(from: self, readOffset: startSample, frames: frameCapacity) > 0 else {
            Log("Failed to write to edited buffer", type: .error)
            return nil
        }

        return editedBuffer
    }
}
