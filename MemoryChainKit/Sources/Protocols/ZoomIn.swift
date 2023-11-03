//
//  ZoomIn.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol ZoomIn {}

extension ZoomIn where Self:UIView {
    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.
     - parameter duration: animation duration
     */
     func zoomIn(duration: TimeInterval = 0.2) {
         self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
         UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
             self.transform = CGAffineTransform.identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }
    /**
     Zoom in any view with specified offset magnification.
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
     func zoomInWithEasing( duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
     UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
         self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
             UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                 self.transform = CGAffineTransform.identity
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }



}
