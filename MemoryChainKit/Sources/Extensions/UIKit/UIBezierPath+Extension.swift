//
//  UIBezierPath+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/31.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

//Extend UIBezier path to create a triangular path
public extension UIBezierPath {
    convenience init(triangleIn rect:CGRect) {
        self.init()
        //2
        let topOfTriangle = CGPoint(x: rect.width / 2, y: 0)
        let bottomLeftOfTriangle = CGPoint(x: 0, y: rect.height)
        let bottomRightOfTriange = CGPoint(x: rect.width, y: rect.height)
        //3
        self.move(to: topOfTriangle)
        self.addLine(to: bottomLeftOfTriangle)
        self.addLine(to: bottomRightOfTriange)
        //4
        self.close()
        
    }
}
