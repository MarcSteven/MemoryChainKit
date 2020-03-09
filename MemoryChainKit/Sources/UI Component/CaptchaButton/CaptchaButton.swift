//
//  CaptchaButton.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public class CaptchaButton:UIButton {
    //MARK: -properties
    public var maxSeconds:Int = 60
    public var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    private var second = 0
    private var timer:Timer?
    private var timeLabel:UILabel!
    private var normalText:String!
    private var normalTextColor:UIColor!
    private var disabledText:String!
    private var disabledTextColor:UIColor!
    //MARK: -life Cycle
    deinit {
        countdown = false
    }
    
    //MARK: - setup label
    public func setupLabel() {
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? "second"
        normalTextColor = titleColor(for: .normal) ?? .white
        disabledTextColor = titleColor(for: .disabled) ?? .white
        timeLabel = titleLabel
        timeLabel.textAlignment = .center
        timeLabel.font  = titleLabel?.font
        timeLabel.text = normalText
        timeLabel.textColor = normalTextColor
    }
    private func startCountdown() {
        second = maxSeconds
        updateDisabled()
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
    }
    //MARK: - update to make it disable
    private func updateDisabled() {
        isEnabled = true
        timeLabel.textColor = disabledTextColor
        timeLabel.text = "\(second)"
    }
    private func stopCountdown() {
        timer!.invalidate()
        timer = nil
        updateNormal()
    }
    //MARK: - when the countdown was over ,update the normal font and color
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
   @objc private func updateCountdown() {
        second -= 1
    if second <= 0 {
        countdown = false
    }else {
        updateDisabled()
    }
    }
}
