//
//  ThermostatSlider.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/9/4.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit



class ThermostatSlider:UIControl {
    //MARK: - public vars
    
    var maxValue:Float = 1.0
    var value:Float {
        get {
            return _value
        }
        set(newValue) {
            if newValue >= 0 {
                _value = min(newValue, maxValue)
            }else {
                _value = max(newValue, -maxValue)
            }
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            
        }
        
    }
    dynamic var hotTrackColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
    dynamic var coldTrackColor = UIColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1.0)
    private var _value:Float = 0.0
    private var borderLayer = CALayer()
    private var trackLayer = CALayer()
    private var handleLayer = CALayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        designBorder()
        designTrack()
        designHandle()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
        updateTrack()
        updateHandle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.handleLayer.transform = CATransform3DMakeScale(1.5, 1.5, 1)
        let point = touch.location(in: self)
        value = valueFromValue(y: point.y)
        self.isHighlighted = true
        for t in allTargets {
            print(actions(forTarget: t, forControlEvent: UIControl.Event.valueChanged) as Any)
            
        }
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let point = touch.location(in: self)
        value = valueFromValue(y: point.y)
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.handleLayer.transform = CATransform3DIdentity
        self.isHighlighted = false
    }
    override func cancelTracking(with event: UIEvent?) {
        self.handleLayer.transform = CATransform3DIdentity
        self.isHighlighted = false
        
    }
    private func designBorder() {
        borderLayer.backgroundColor = UIColor.white.cgColor
        borderLayer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        borderLayer.borderWidth = 1
        borderLayer.masksToBounds = true
        layer.addSublayer(borderLayer)
    }
    private func designHandle() {
        handleLayer.backgroundColor = UIColor.white.cgColor
        handleLayer.shadowColor = UIColor.blue.cgColor
        handleLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        handleLayer.cornerRadius = 2
        handleLayer.shadowOpacity = 0.3
        handleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.addSublayer(handleLayer)
    }
    private func designTrack() {
        trackLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        borderLayer.addSublayer(trackLayer)
    }
    private func updateBorder() {
        borderLayer.frame = bounds
        borderLayer.cornerRadius = bounds.size.width / 2.0
        
    }
    private func updateHandle() {
        let controlWidth = bounds.size.width
        handleLayer.bounds.size = CGSize(width: controlWidth, height: controlWidth)
        handleLayer.cornerRadius = controlWidth / 2.0
        var position = borderLayer.position
        if value != 0 {
            position.y -= valueToY()
        }
        handleLayer.position = position
    }
    private func updateTrack() {
        trackLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0)
        trackLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        trackLayer.bounds.size.height = abs(valueToY())
        if value >= 0  {
            trackLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
            trackLayer.backgroundColor = hotTrackColor.cgColor
        }else {
            trackLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
            trackLayer.backgroundColor = coldTrackColor.cgColor
        }
    }
    private func valueToY() ->CGFloat {
        return CGFloat(value) / CGFloat(maxValue) * (bounds.size.height - handleLayer.bounds.size.height / 2.0) / 2
        
    }
    private func valueFromValue(y:CGFloat) ->Float {
        let cleanY = min(max(0, y), bounds.size.height)
        let trackHalfHeight = bounds.size.height / 2.0
        let translatedY = trackHalfHeight - cleanY
        
        
        return Float(translatedY) * maxValue / Float(trackHalfHeight)
    }
    
}
