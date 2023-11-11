//
//  ARIScanView+GetScanRect.swift
//  ARIScanCodeKit
//
//  Created by marc zhao on 2022/4/7.
//

import UIKit


//MARK: - 公开方法
public extension ARIScanView {
    
    /// 获取扫描动画的Rect
    func getScanRectForAnimation() -> CGRect {
        let XRetangleLeft = viewStyle.xScanRetangleOffset
        var sizeRetangle = CGSize(width: frame.size.width - XRetangleLeft * 2,
                                  height: frame.size.width - XRetangleLeft * 2)
        
        if viewStyle.whRatio != 1 {
            let w = sizeRetangle.width
            let h = w / viewStyle.whRatio
            sizeRetangle = CGSize(width: w, height: CGFloat(Int(h)))
        }
        
        // 扫码区域Y轴最小坐标
        let YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height / 2.0 - viewStyle.centerUpOffset
        // 扫码区域坐标
        let cropRect = CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height)
        
        return cropRect
    }
    
}
