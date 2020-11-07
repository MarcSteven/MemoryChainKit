//
//  CGRect+Helper.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
//MARK: - properties 
public extension CGRect {
    
        /// Returns a new `CGRect` instance scaled up or down, with the same center as the original `CGRect` instance.
    /// - Parameters:
    ///   - ratio: The ratio to scale the `CGRect` instance by.
    /// - Returns: A new instance of `CGRect` scaled by the given ratio and centered with the original rect.
    func scaleAndCenter(withRatio ratio: CGFloat) -> CGRect {
        let scaleTransform = CGAffineTransform(scaleX: ratio, y: ratio)
        let scaledRect = applying(scaleTransform)
        
        let translateTransform = CGAffineTransform(translationX: origin.x * (1 - ratio) + (width - scaledRect.width) / 2.0, y: origin.y * (1 - ratio) + (height - scaledRect.height) / 2.0)
        let translatedRect = scaledRect.applying(translateTransform)
        
        return translatedRect
    }

    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
    
    func halveRect()->CGRect {
        return CGRect(x: self.x/2, y: self.y/2, width: self.width/2, height: self.height/2)
    }
    
    func rectReduce(maigin: CGFloat)->CGRect {
        return CGRect(x: self.x+maigin, y: self.y+maigin, width: self.width-maigin*2, height: self.height-maigin*2)
    }
    
    func rectIncrease(maigin: CGFloat)->CGRect {
        return CGRect(x: self.x-maigin, y: self.y-maigin, width: self.width+maigin*2, height: self.height+maigin*2)
    }
    func rect(point: CGPoint, xRemainder: Bool, yRemainder: Bool) -> CGRect {
        let xDiv = divided(atDistance: point.x, from: .minXEdge)
        let x = xRemainder ? xDiv.remainder : xDiv.slice
        let yDiv = x.divided(atDistance: point.y, from: .minYEdge)
        return yRemainder ? yDiv.remainder : yDiv.slice
    }

    func area(corner: DestinationViewCorner) -> CGFloat {
        let (xRemainder, yRemainder): (Bool, Bool)
        switch corner.position {
        case .topLeft:
            (xRemainder, yRemainder) = (false, false)
        case .topRight:
            (xRemainder, yRemainder) = (true, false)
        case .bottomLeft:
            (xRemainder, yRemainder) = (false, true)
        case .bottomRight:
            (xRemainder, yRemainder) = (true, true)
        }
        let frame = rect(point: corner.point, xRemainder: xRemainder, yRemainder: yRemainder)
        return frame.width * frame.height
    }
}


struct DestinationViewCorner {

    enum Position: Int {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight

        var xModifier: CGFloat {
            switch self {
            case .topLeft, .bottomLeft: return -1
            case .topRight, .bottomRight: return 1
            }
        }

        var yModifier: CGFloat {
            switch self {
            case .topLeft, .topRight: return -1
            case .bottomLeft, .bottomRight: return 1
            }
        }

        var xSizeModifier: CGFloat {
            switch self {
            case .topLeft, .bottomLeft: return -1
            case .topRight, .bottomRight: return 0
            }
        }

        var ySizeModifier: CGFloat {
            switch self {
            case .topLeft, .topRight: return -1
            case .bottomLeft, .bottomRight: return 0
            }
        }

    }

    let rect: CGRect
    let position: Position

    var point: CGPoint {
        switch position {
        case .topLeft: return CGPoint(x: rect.minX, y: rect.minY)
        case .topRight: return CGPoint(x: rect.maxX, y: rect.minY)
        case .bottomLeft: return CGPoint(x: rect.minX, y: rect.maxY)
        case .bottomRight: return CGPoint(x: rect.maxX, y: rect.maxY)
        }
    }

}

