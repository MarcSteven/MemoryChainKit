//
//  MCUIHelper.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/12/23.
//  Copyright © 2021 Marc Steven(https://https://github.com/MarcSteven). All rights reserved.
//



import Foundation
import UIKit
import AVFoundation

open class MCUIHelper:NSObject {
    
    /// 单例
    static let shared = MCUIHelper()
    
    private override init() {}
}
//Device
extension MCUIHelper {
    static var isIpad:Bool {
        return UIDevice.isIpad
    }
    static var isIphone:Bool {
        return UIDevice.isIPhone
    }
    static var isIphoneXOrLater:Bool {
        return UIDevice.iPhoneXOrLater
    }
    static var isTv:Bool {
        return UIDevice.isTV
    }
    static var isSimulator:Bool {

        let environment = ProcessInfo.processInfo.environment
        let isSimulator = environment["SIMULATOR_UDID"] != nil
        return isSimulator
    }
    static var isDevice:Bool {
        let environment = ProcessInfo.processInfo.environment

        
        let isSimulator = environment["SIMULATOR_UDID"] != nil
        return isSimulator
    }
    
    static var isIOS11:Bool {
        return UIDevice.current.systemVersion.doubleValue >= 11.0
    }
    static var isIOS13:Bool {
        return UIDevice.current.systemVersion.doubleValue >= 13.0
    }
    static var isCarPlay:Bool {
        return UIDevice.isCarPlay
    }
   static  var screenFor58Inch:CGSize {
        return CGSize(width: 375, height: 812)
    }
    static var screenFor55Inch:CGSize {
        return CGSize(width: 414, height: 736)
    }
    static var screenFor61Inch:CGSize {
        return CGSize(width: 414, height: 896)
    }
    static var screen47Inch:CGSize {
        return CGSize(width: 375, height: 667)
    }
    static var screen4Inch:CGSize {
        return CGSize(width: 320, height: 568)
    }
    static var screen35Inch:CGSize {
        return CGSize(width: 320,height:480 )
    }
    static var isScreen35Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screen35Inch
    }
    static var rootViewController:UIViewController {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    static var isScreen58Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor58Inch
    }
    static var isScreen55Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor55Inch
    }
    static var isScreen47Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screen47Inch
    }
    static var isScreen4Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenWidth) == screen4Inch
    }
    static var isScreen61Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor61Inch
    }
    //MARK: - iPad Size
    static var screenForIpad129Inch:CGSize {
        return CGSize(width: 1024, height: 1366)
    }
    static var screenForIpadPro11Inch:CGSize {
        return CGSize(width:834, height:1194)
    }
    static var screenForIpad105Inch:CGSize {
        return CGSize(width: 834, height: 1112)
    }
    static var screenForIpad102Inch:CGSize {
        return CGSize(width: 810, height: 1080)
    }
    static var screenForIpad97Inch:CGSize {
        return CGSize(width: 768, height: 1024)
    }
    static var isScreen129Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenForIpad129Inch
    }
    static var safeAreaInsetForIphoneX:UIEdgeInsets {
        if !isScreen58Inch {
            return UIEdgeInsets.zero
        }
        let orientation = UIApplication.shared.statusBarOrientation
        switch orientation {
        case .portrait:
            return UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 34)
            
        case .portraitUpsideDown:
            return UIEdgeInsets(top: 34, left: 0, bottom: 0, right: 44)
            
        case .landscapeLeft,.landscapeRight:
            return UIEdgeInsets(top: 0, left: 44, bottom: 21, right: 44)
        case .unknown:
            return UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 34)
            
       
        @unknown default:
            fatalError()
        }
    }
}

// audio
extension MCUIHelper {
    
    /// configure audio session
    /// - Parameter category: audio session categories
    func setAudioSession(category:AVAudioSession.Category) {
        
        let categories:[AVAudioSession.Category] = [
        .ambient,
        .playAndRecord,
        .playback,
        .record,
        .multiRoute,
        .soloAmbient
        ]
        if categories.contains(category) {
            return
        }
        try? AVAudioSession.sharedInstance().setCategory(category)
        
    }
    
}

// get one point pixle
extension MCUIHelper {
    static var onePointPixle:CGFloat {
        return 1 / UIScreen.main.scale
    }
    static var screenWidth:CGFloat {
        return UIScreen.screenWidth
    }
    static var screenHeight:CGFloat {
        return UIScreen.screenHeight
    }
    static var screenScale:CGFloat {
        return UIScreen.main.scale
    }
    
    static var nativeScale:CGFloat {
    return  UIScreen.main.nativeScale
    }
    static var nativeBounds:CGRect {
        return UIScreen.main.nativeBounds
    }
    
}
// rotate device
public extension MCUIHelper {
    
    /// 是否旋转设备方向
    /// - Parameter orientation: 设备方向
    /// - Returns: 如果旋转则返回true。否则为false
    @discardableResult
    static func isRotateDeviceOrientation(_ orientation:UIDeviceOrientation) ->Bool {
        if UIDevice.current.orientation == orientation {
            UIViewController.attemptRotationToDeviceOrientation()
            return false
        }
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        return true
    }
    func imageFromVideo( url:URL,at time:TimeInterval) ->UIImage? {
        let asset = AVURLAsset(url: url)
        let assetIG = AVAssetImageGenerator(asset: asset)
        let cmTime = CMTime(seconds: time, preferredTimescale: 60)
        let thumbImageRef:CGImage 
        do {
            thumbImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
        }catch let error {
            print("error:\(error)")
            return nil
        }
        return UIImage(cgImage: thumbImageRef)
    }
}
