//
//  MCDropdownMenu+Animations.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 动画相关方法
public extension MCDropdownView {
    
    func addContentAnimation(forState state: MCDropDownState) {
        let contentBounceAnim = CAKeyframeAnimation(keyPath: "position")
        contentBounceAnim.duration = animationDuration
        contentBounceAnim.isRemovedOnCompletion = false
        contentBounceAnim.fillMode = .forwards
        contentBounceAnim.values = contentPositionValues(forState: state)
        contentBounceAnim.timingFunctions = contentTimingFunctions(forState: state)
        contentBounceAnim.keyTimes = contentKeyTimes(forState: state)
        
        contentWrapperView.layer.add(contentBounceAnim, forKey: nil)
        contentWrapperView.layer.setValue(contentBounceAnim.values?.last, forKeyPath: "position")
    }
    
    func addContainerAnimation(forState state: MCDropDownState) {
        let containerScaleAnim = CAKeyframeAnimation(keyPath: "transform")
        containerScaleAnim.duration = animationDuration
        containerScaleAnim.isRemovedOnCompletion = false
        containerScaleAnim.fillMode = .forwards
        containerScaleAnim.values = containerTransformValues(forState: state)
        containerScaleAnim.timingFunctions = containerTimingFunctions(forState: state)
        containerScaleAnim.keyTimes = containerKeyTimes(forState: state)
        
        containerWrapperView.layer.add(containerScaleAnim, forKey: nil)
        containerWrapperView.layer.setValue(containerScaleAnim.values?.last, forKeyPath: "transform")
    }
    
    func contentPositionValues(forState state: MCDropDownState) -> [CGPoint] {
        let currentContentCenter = contentWrapperView.layer.position
        var values = [currentContentCenter]
        
        if state == .willOpen || state == .didOpen {
            if (direction == .top) {
                values.append(CGPoint(x: currentContentCenter.x, y: desContentCenter.y + CGFloat(animationBounceHeight)))
            }
            else {
                values.append(CGPoint(x: currentContentCenter.x, y: desContentCenter.y - CGFloat(animationBounceHeight)))
            }
            values.append(CGPoint(x: currentContentCenter.x, y: desContentCenter.y))
        }
        else {
            if (direction == .top) {
                values.append(CGPoint(x: currentContentCenter.x, y: currentContentCenter.y + CGFloat(animationBounceHeight)))
            }
            else {
                values.append(CGPoint(x: currentContentCenter.x, y: currentContentCenter.y - CGFloat(animationBounceHeight)))
            }
            values.append(CGPoint(x: currentContentCenter.x, y: originContentCenter.y))
        }
        
        return values
    }
    
    func contentKeyTimes(forState state: MCDropDownState) -> [NSNumber] {
        return [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
    }
    
    func contentTimingFunctions(forState state: MCDropDownState) -> [CAMediaTimingFunction] {
        return [CAMediaTimingFunction(name: .easeOut), CAMediaTimingFunction(name: .easeInEaseOut)]
    }
    
    func containerTransformValues(forState state: MCDropDownState) -> [CATransform3D] {
        let transform = containerWrapperView.layer.transform
        var values = [transform]
        
        if state == .willOpen || state == .didOpen {
            let scale = CGFloat(closedScale - defaultAnimationBounceScale)
            values.append(CATransform3DScale(transform, scale, scale, scale))
            values.append(CATransform3DScale(transform, CGFloat(closedScale), CGFloat(closedScale), CGFloat(closedScale)))
        }
        else {
            let scale = CGFloat(1 - defaultAnimationBounceScale)
            values.append(CATransform3DScale(transform, scale, scale, scale))
            values.append(CATransform3DIdentity)
        }
        
        return values
    }
    
    func containerKeyTimes(forState state: MCDropDownState) -> [NSNumber] {
        return [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
    }
    
    func containerTimingFunctions(forState state: MCDropDownState) -> [CAMediaTimingFunction] {
        return [CAMediaTimingFunction(name: .easeOut), CAMediaTimingFunction(name: .easeInEaseOut)]
    }
    
}
