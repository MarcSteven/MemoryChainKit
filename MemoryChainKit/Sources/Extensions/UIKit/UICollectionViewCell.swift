//
//  UICollectionViewCell.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    @objc open func select(animated:Bool,
                           scrollPosition: UICollectionView.ScrollPosition = [],
                           shouldNotifyDelegate:Bool) {
        guard let collectionView = collectionView,
            let indexPath = collectionView.indexPath(for: self)
        else {
            return
        }
        
    }
    private var collectionView:UICollectionView? {
        responder()
    }
}
