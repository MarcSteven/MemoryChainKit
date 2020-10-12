//
//  RYUIHelper.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

open class RYUIHelper:NSObject {
    
    /// 单例
    static let shared = RYUIHelper()
    
    /// 初始化
    private override init() {}
}
//Device
extension RYUIHelper {
    
    /// 是iPad
    static var isIpad:Bool {
        return UIDevice.isIpad
    }
    
    /// 是iPhone
    static var isIphone:Bool {
        return UIDevice.isIPhone
    }
    
    /// iPhone X以及以上机型
    static var isIphoneXOrLater:Bool {
        return UIDevice.iPhoneXOrLater
    }
    
    /// 是TV
    static var isTv:Bool {
        return UIDevice.isTV
    }
    
    /// 是否是模拟器
    static var isSimulator:Bool {

        let environment = ProcessInfo.processInfo.environment
        let isSimulator = environment["SIMULATOR_UDID"] != nil
        return isSimulator
    }
    
    /// is device
    static var isDevice:Bool {
        let environment = ProcessInfo.processInfo.environment

        
        let isSimulator = environment["SIMULATOR_UDID"] != nil
        return isSimulator 
    }
    
    /// is iOS 11
    static var isIOS11:Bool {
        return UIDevice.current.systemVersion.doubleValue >= 11.0
    }
    
    /// is iOS13
    static var isIOS13:Bool {
        return UIDevice.current.systemVersion.doubleValue >= 13.0
    }
    
    /// is iOS14
    static var isIOS14:Bool {
        return UIDevice.current.systemVersion.doubleValue >= 14.0
    }
    
    /// is Car play
    static var isCarPlay:Bool {
        return UIDevice.isCarPlay
    }
    
    /// 5.8 inch screen
   static  var screenFor58Inch:CGSize {
    if isLandscape {
        return CGSize(width: 812, height: 375)
    }else {
        return CGSize(width: 375, height: 812)
    }
    }
    
    /// 5.5 inch screen
    static var screenFor55Inch:CGSize {
        if isLandscape {
            return CGSize(width: 736, height: 414)
        }else {
            return CGSize(width: 414, height: 736)
        }
        }
    
    /// 6.5 inch screen
    static var screenFor65Inch:CGSize {
        if isLandscape {
            return CGSize(width: 414, height: 896)
        }else {
            return CGSize(width: 896, height: 414)
        }
    }
    
    /// 6.1 inch screen
    static var screenFor61Inch:CGSize {
        if isLandscape {
            return CGSize(width: 896, height: 414)
        }else {
        return CGSize(width: 414, height: 896)
        }
        }
    
    /// 4.7 screen
    static var screen47Inch:CGSize {
        if isLandscape {
            return CGSize(width: 667, height: 375)
        }else {
        return CGSize(width: 375, height: 667)
        }
        }
    
    /// screen 4 inch
    static var screen4Inch:CGSize {
        if isLandscape {
            return CGSize(width: 568, height: 320)
        }else {
        return CGSize(width: 320, height: 568)
    }
    }
    
    /// 3.5 screen
    static var screen35Inch:CGSize {
        if isLandscape {
            return CGSize(width: 480, height: 320)
        }else {
        return CGSize(width: 320,height:480 )
    }
    }
   
    
    /// is 3.5 inch
    static var isScreen35Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screen35Inch
    }
    
    /// root view controller
    static var rootViewController:UIViewController {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    
    /// 5.8 screen inch
    static var isScreen58Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor58Inch
    }
    
    /// screen 5.5 inch
    static var isScreen55Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor55Inch
    }
    
    /// 4.7 screen inch
    static var isScreen47Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screen47Inch
    }
    
    /// is 4 inch screen
    static var isScreen4Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenWidth) == screen4Inch
    }
    
    /// 6.1 inch screen
    static var isScreen61Inch:Bool {
        return CGSize(width: UIScreen.screenWidth, height: UIScreen.screenHeight) == screenFor61Inch
    }
    
    /// is landscape
    static var isLandscape:Bool {
        return UIDevice.current.orientation == .landscapeLeft
    }
    
    ///
    static var portrait:Bool {
        return UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown
    }
    //MARK: - iPad Size
    static var screenForIpad129Inch:CGSize {
        return CGSize(width: 1024, height: 1366)
    }
    
    /// iPad pro 11 inch
    static var screenForIpadPro11Inch:CGSize {
        return CGSize(width:834, height:1194)
    }
    
    /// 10.5 inch iPad
    static var screenForIpad105Inch:CGSize {
        return CGSize(width: 834, height: 1112)
    }
    
    /// iPad 10.2 inch
    static var screenForIpad102Inch:CGSize {
        return CGSize(width: 810, height: 1080)
    }
    
    /// iPad 9.7 inch
    static var screenForIpad97Inch:CGSize {
        return CGSize(width: 768, height: 1024)
    }
    
    /// is 12.9 inch iPad
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
extension RYUIHelper {
    
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

extension RYUIHelper {
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
    static var udid:String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    static var iOSVersion:Double {
        return UIDevice.current.systemVersion.doubleValue
    }
    
}
// rotate device
extension RYUIHelper {
    
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
}


