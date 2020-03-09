//
//  CollectionViewDataSource.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/11.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol CollectionViewDataSource {
    func numberOfSections(in collectionView:UICollectionView) ->Int
    func collectionView(_ collectionView:UICollectionView,
                        numberOfItemsInSection section:Int) ->Int
    func collectionView( _ collectionView:UICollectionView,
                         cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    func collectionView( _ collectionView:UICollectionView,
                         canMoveItemAt indexPath:IndexPath) ->Bool
    mutating func collectionView(_ collectionView:UICollectionView,
                                 moveItemAt sourceIndexPath:IndexPath,to destinationIndexPath:IndexPath)
}
//Sections
public extension CollectionViewDataSource {
    func numberOfSections(in collectionView:UICollectionView) ->Int {
        return 1
    }
    
}
//Moving
public extension CollectionViewDataSource {
    func collectionView(_ collectionView:UICollectionView,
                        canMoveItemAt indexPath:IndexPath) ->Bool {
        return false
    }
    mutating func collectionView(_ collectionView:UICollectionView,moveItemAt sourceIndexPath:IndexPath,to destinationIndexPath:IndexPath) {
        
    }
}

