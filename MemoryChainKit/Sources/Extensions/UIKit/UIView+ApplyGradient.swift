//
//  UIView+ApplyGradient.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/11.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


typealias GradientPoints = (startPoint:CGPoint,endPoint:CGPoint)
//Gradient orientation 
enum GradientOrientation {
    case topRightToBottomLeft,topLeftToBottomRight,horizontal,vertical
    var startPoint:CGPoint {
        return points.startPoint
    }
    var endPoint:CGPoint {
        return points.endPoint
    }
    var points:GradientPoints {
        get {
            switch self {
            case .topRightToBottomLeft:
                return (CGPoint(x: 0.0, y: 1.0),CGPoint(x: 1.0, y: 0.0))
            case .topLeftToBottomRight:
                return (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1, y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5),CGPoint(x: 1.0, y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 0.0, y: 1.0))
           
            }
        }
    }
}
//MARK: - configure gradient to the view
extension UIView {
    
    func configureGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func configureGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation)  {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}
