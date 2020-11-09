//
//  UISliderExtesnion.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/9.
//  Copyright © 2020 Marc Steven(https://marcsteven.top). All rights reserved.
//

#if canImport(UIKit) && os(iOS)
import UIKit


public extension UISlider {
    func setValue(
            _ value: Float,
            animated: Bool = true,
            duration: TimeInterval = 1,
            completion: (() -> Void)? = nil) {
            
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
