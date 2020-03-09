//
//  KeyboardInfo.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/10/13.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit

struct KeyboardInfo {
    //MARK: - properties
    let animationCure:UIView.AnimationCurve
    let animationDuration:Double
    let isLocal:Bool
    let beginFrame:CGRect
    let endFrame :CGRect
    let animationCurveKey = UIResponder.keyboardAnimationCurveUserInfoKey
    let animationDurationKey = UIResponder.keyboardAnimationDurationUserInfoKey
    let isLocalKey = UIResponder.keyboardIsLocalUserInfoKey
    let beginFrameKey = UIResponder.keyboardFrameBeginUserInfoKey
    let endFrameKey = UIResponder.keyboardFrameEndUserInfoKey
    
    //MARK: - method
    init?(_ notification:Notification) {
        guard let userInfo = notification.userInfo else {
            return nil
        }
        guard let animationCurveUserInfo = userInfo[animationCurveKey],
        let animationCureRaw = animationCurveUserInfo as? Int,
            let animationCurve = UIView.AnimationCurve(rawValue: animationCureRaw)
        
        else {
            return nil
        }
        self.animationCure = animationCurve
        guard let animationDurationUserInfo = userInfo[animationDurationKey],
        let animationDuration = animationDurationUserInfo as? Double
        else {
            return nil
            
        }
        self.animationDuration = animationDuration
        guard let isLocalUserInfo = userInfo[isLocalKey],
        let isLocal = isLocalUserInfo as? Bool
            else {
            return nil
        }
        self.isLocal = isLocal
        guard let beginFrameUserInfo = userInfo[beginFrameKey],
        let beginFrame = beginFrameUserInfo as? CGRect
        else {
            return nil
        }
        self.beginFrame = beginFrame
        guard let endFrameUserInfo = userInfo[endFrameKey],
        let endFrame = endFrameUserInfo as? CGRect
        else {
            return nil
        }
        self.endFrame = endFrame
    }
}
