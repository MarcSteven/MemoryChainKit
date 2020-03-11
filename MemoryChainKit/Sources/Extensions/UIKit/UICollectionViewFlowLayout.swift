//
//  UICollectionViewFlowLayout.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/2.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UICollectionViewFlowLayout {
    func retrieve<Value> (using function:(UICollectionViewFlowLayout,UICollectionView) ->Value?,fallback:() ->Value) ->Value{
        guard let collectionView = collectionView,
        let delegate = collectionView.delegate,
        let flowDelegate = delegate as? UICollectionViewFlowLayout,
        let value = function(flowDelegate,collectionView)
        else {
            
            return fallback()
        }
        return value
    }
}
