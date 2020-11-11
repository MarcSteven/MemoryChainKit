//
//  EqualSpaceCollectionViewFlowLayout.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/12.
//  Copyright © 2020 Marc Steven(https://marcsteven.top). All rights reserved.
//

import UIKit


public enum CellAlignDirection:NSInteger {
    case left = 0
    case center = 1
    case right = 2
}


open class EqualSpaceCollectionViewFlowLayout:UICollectionViewFlowLayout {
    // MARK: cell space
    var cellSpace :CGFloat {
        didSet {
            self.minimumLineSpacing = cellSpace
        }
    }
    var alignDirection: CellAlignDirection  = .center
    var sumOfCellWidth:CGFloat = 0.0
    
    override init() {
        cellSpace = 5.0
        super.init()
        scrollDirection = UICollectionView.ScrollDirection.vertical
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    convenience init(_ alignDirection:CellAlignDirection){
        self.init()
        self.alignDirection = alignDirection
    }
    convenience init(_ alignDirection: CellAlignDirection, _ cellSpace: CGFloat){
        self.init()
        self.alignDirection = alignDirection
        self.cellSpace = cellSpace
    }
    
    required public init?(coder aDecoder: NSCoder) {
        cellSpace = 5.0
        super.init(coder: aDecoder)
        scrollDirection = UICollectionView.ScrollDirection.vertical
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<layoutAttributes.count{
            
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumOfCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY{
                if currentAttr.representedElementKind == UICollectionView.elementKindSectionHeader{
                    layoutAttributes_t.removeAll()
                    sumOfCellWidth = 0.0
                }else if currentAttr.representedElementKind == UICollectionView.elementKindSectionFooter{
                    layoutAttributes_t.removeAll()
                    sumOfCellWidth = 0.0
                }else{
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumOfCellWidth = 0.0
                }
            }else if currentY != nextY{
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumOfCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]){
        var nowWidth : CGFloat = 0.0
        switch alignDirection {
        case .left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.cellSpace
            }
            break;
        case .center:
            nowWidth = (self.collectionView!.frame.size.width - sumOfCellWidth - (CGFloat(layoutAttributes.count - 1) * cellSpace)) / 2
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.cellSpace
            }
            break;
        case .right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count{
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - cellSpace
            }
            break;
        }
    }
    

    
}
