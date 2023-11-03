//
//  CALayer+Color.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import QuartzCore

extension CALayer {
    /**A convenience method to return the color at the given point in 'self'
     @parameter :
     point : use to detect the color
     */
    public func color(at point:CGPoint) ->UIColor {
        let width = 1
        let height = 1
        let bitsPerComponent = 8
        let bytesPerRow = 4 * height
        let pixel:[UInt8] = [0,0,0,0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: UnsafeMutablePointer(mutating: pixel), width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.translateBy(x: -point.x, y: -point.y)
        render(in: context)
        return UIColor(red: CGFloat(pixel[0]) / 255, green: CGFloat(pixel[1]) / 255, blue: CGFloat(pixel[2]) / 255, alpha: CGFloat(pixel[3]) / 255)
    }
}
