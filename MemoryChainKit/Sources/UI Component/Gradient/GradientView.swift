//
//  GradientView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/15.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


 @IBDesignable  class GradientView :UIView {
    // MARK:- gradient layer
    private var gradient:CAGradientLayer?
    
    //An array of CGColorRef objects defining the color of each gradient stop.Animatable.
    var colors:[Any]?
    // the gradient start color
    @IBInspectable var startColor:UIColor? {
        didSet {
            updateGradient()
        }
    }
    // the gradient end color
    @IBInspectable var endColor:UIColor? {
        didSet {
            updateGradient()
        }
    }
    // The gradient angle ,in degrees anticlockwise from 0
    @IBInspectable var angle:CGFloat = 270 {
        didSet {
            updateGradient()
        }
    }
        //MARK:- Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installGradientLayer()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        installGradientLayer()
    }
    //MARK:- construct gradient layer
    private func createGradient() ->CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        return gradient
    }
    //MARK:-install gradient layer
    private func installGradientLayer() {
        if let gradient = self.gradient {
            gradient.removeFromSuperlayer()
        }
        let gradient = createGradient()
        self.layer.addSublayer(gradient)
        self.gradient = gradient
        
    }
    //MARK:-update an exsiting gradient
    private func updateGradient() {
        if let gradient = self.gradient {
            let startColor = self.startColor ?? UIColor.clear
            let endColor = self.endColor ?? UIColor.clear
            gradient.colors = [startColor.cgColor,endColor.cgColor]
            let (start,end) = gradientPointForangle(self.angle)
            gradient.startPoint = start
            gradient.endPoint = end
        }
    }
    //Create vector point in the direction of angle
    private func gradientPointForangle(_ angle:CGFloat) ->(CGPoint,CGPoint) {
        let end = pointForAngle(angle)
        let start = oppositePoint(end)
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0,p1)
    }
    // get a point correspoing to the angle
    private func pointForAngle(_ angle:CGFloat) ->CGPoint {
        //Convert degress to radians
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        //(x,y) is in terms unit circle.Extrapolate to unit square to get full vector length
        if abs(x) > abs(y) {
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        }else {
            y = y > 0 ? 1 : -1
            y = x / tan(radians)
        }
        return CGPoint(x: x, y: y)
    }
    //return the opposite point in the signed unit square
    private func oppositePoint(_ point:CGPoint) ->CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    //Transform point in unit space to gradient space
    private func transformToGradientSpace(_ point:CGPoint) ->CGPoint {
        return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
    //Ensure the gradient get initialized when the view is created in Xib
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        installGradientLayer()
        updateGradient()
    }
}
