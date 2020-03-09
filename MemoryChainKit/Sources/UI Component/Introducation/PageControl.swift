//
//  PageControl.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


//MARK: - enum for pageControl alignment
public enum PageControlAlignment {
    case center,left,right
}

open class PageControl:UIControl {
    public var numberOfPages:Int = 0 {
        didSet {
            setupItems()
        }
    }
    //dot space
    public var spacing:CGFloat = 0 {
        didSet {
            
        }
    }
    //dot size
    public var dotSize:CGSize  = CGSize(width: 8, height: 8) {
        didSet {
            refreshFrame()
        }
    }
    public var currentDotSize:CGSize? {
        didSet {
            refreshFrame()
        }
    }
    public var alignment:PageControlAlignment = .center {
        didSet {
            refreshFrame()
        }
    }
    public var dotRadius:CGFloat? {
        didSet {
            refreshFrame()
        }
    }
    public var currentDotRadius:CGFloat? {
        didSet {
            refreshFrame()
        }
    }
    public var currentPage:Int = 0 {
        didSet {
            changeColor()
            refreshFrame()
        }
    }
    public var currentPageIndicatorTintColor:UIColor = UIColor.white {
        didSet {
            changeColor()
        }
    }
    public var pageIndicatorTintColor:UIColor = UIColor.gray {
        didSet {
            changeColor()
        }
    }
    public var dotImage:UIImage? {
        didSet {
            changeColor()
        }
    }
    public var currentDotImage:UIImage? {
        didSet  {
            changeColor()
        }
    }
    public var isHiddenForSinglePage:Bool = false {
        didSet {
            isHidden = isHiddenForSinglePage && numberOfPages == 1 ? true :false
        }
    }
    fileprivate var items = [UIImageView]()
    
    
    fileprivate func setupItems() {
        for item  in items {
            item.removeFromSuperview()
        }
        items.removeAll()
        for i in 0..<numberOfPages {
            let frame = getFrame(index: i)
            let item = UIImageView(frame: frame)
            addSubview(item)
            items.append(item)
        }
        refreshFrame()
        changeColor()
        
    }
    fileprivate func refreshFrame() {
        for (index,item) in items.enumerated() {
            let frame = getFrame(index: index)
            item.frame = frame
            var radius = dotRadius == nil ? frame.size.height/2 : dotRadius!
            if currentPage == index {
                if currentDotImage != nil {
                    radius = 0
                }
                item.layer.cornerRadius = currentPageIndicatorTintColor == nil ? radius : currentDotRadius!
            }else {
                if dotImage != nil {radius = 0}
                item.layer.cornerRadius = radius
            }
            item.layer.masksToBounds = true
            
        }
        
    }
    fileprivate func getFrame(index:Int)->CGRect {
        let itemWidth = dotSize.width + spacing
        var currentSize = currentDotSize
        if currentSize == nil {
            currentSize = dotSize
        }
        let currentItemWidth = (currentSize?.width)! + spacing
        let totalWidth = itemWidth * CGFloat(numberOfPages - 1) + currentItemWidth + spacing
        var orignX:CGFloat = 0
        switch alignment {
        case .center:
            orignX = (frame.size.width - totalWidth) / 2 + spacing
        case .left:
            orignX = spacing
        case .right:
            orignX = frame.size.width - totalWidth + spacing
            
            }
        var x :CGFloat = 0
        if index <= currentPage {
            x = orignX + CGFloat(index - 1) * itemWidth
        }else {
            x = orignX + CGFloat(index - 1) * itemWidth + currentItemWidth
        }
        let width = index == currentPage ? (currentSize?.width)! : dotSize.width
        let height = index == currentPage ? (currentSize?.height)! : dotSize.height
        let y = (frame.size.height - height) / 2
        return CGRect(x: x, y: y, width: width, height: height)
        
    }
    fileprivate func changeColor() {
        for (index,item) in items.enumerated() {
            if currentPage == index {
                item.backgroundColor = currentDotImage == nil ? currentPageIndicatorTintColor : UIColor.clear
                item.image = currentDotImage
                if currentDotImage != nil {
                    item.layer.cornerRadius = 0
                    
                }
            }else {
                item.backgroundColor = dotImage == nil ? pageIndicatorTintColor :UIColor.clear
                item.image = dotImage
                if dotImage != nil {
                    item.layer.cornerRadius = 0
                }
            }
            
        }
        
    }
}
extension PageControl {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}
