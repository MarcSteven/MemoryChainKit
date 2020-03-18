//
//  UICollectionView+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/30.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//


import UIKit

public extension UICollectionView {
    
    func numberOfRows(using delegate:UIViewController & UICollectionViewDelegateFlowLayout) ->Int {
        let layout = (collectionViewLayout as? UICollectionViewFlowLayout)!
        var totalNumberOfItems = 0
        for section in 0...numberOfSections - 1 {
            totalNumberOfItems += numberOfItems(inSection: section)
            
        }
        let insets = layout.sectionInset
        let width = bounds.width - insets.left - insets.right
        let indexPath = IndexPath(row: 0, section: 0)
        let cellWidth = delegate.collectionView!(self, layout: layout, sizeForItemAt: indexPath).width
        let cellSpacing = layout.minimumLineSpacing
        let numberOfItemsInRow = floor(width / (cellWidth + cellSpacing))
        let numberOfRows = ceil(CGFloat(totalNumberOfItems) / numberOfItemsInRow)
        return Int(numberOfRows)
        
    }
}
