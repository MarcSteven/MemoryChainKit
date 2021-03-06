//
//  UISlider+Extension.swift
//  CrossBorderHelp
//
//  Created by Marc Zhao on 2018/5/25.
//  Copyright © 2018年 kuajinghelp. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if os(iOS)
// MARK: - Methods
public extension UISlider {
    
    ///  Set slide bar value with completion handler.
    ///
    /// - Parameters:
    ///   - value: slider value.
    ///   - animated: set true to animate value change (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: an optional completion handler to run after value is changed (default is nil)
    public func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
    
}
#endif

#endif
