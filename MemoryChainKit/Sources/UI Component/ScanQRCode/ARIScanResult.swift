//
//  ARIScanResult.swift
//  ARIScanCodeKit
//
//  Created by marc zhao on 2022/4/19.
//

import Foundation
import UIKit


public struct ARIScanResult {
    
    /// 码内容
    public var strScanned: String?
    
    /// 扫描图像
    public var imgScanned: UIImage?
    
    /// 码的类型
    public var strBarCodeType: String?

    /// 码在图像中的位置
    public var arrayCorner: [AnyObject]?

    public init(str: String?, img: UIImage?, barCodeType: String?, corner: [AnyObject]?) {
        strScanned = str
        imgScanned = img
        strBarCodeType = barCodeType
        arrayCorner = corner
    }
}
