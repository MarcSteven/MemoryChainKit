//
//  AVCaptureDeviceExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import AVFoundation

public extension AVCaptureDevice.Position {
    func opposite() -> AVCaptureDevice.Position {
        switch self {
        case .back:
            return .front
        case .front:
            return .back
        default:
            return self
        }
    }
}

