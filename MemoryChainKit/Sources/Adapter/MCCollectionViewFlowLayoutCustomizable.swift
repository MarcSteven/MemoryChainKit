//
//  File.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

// MARK: - MCCollectionViewFlowLayoutCustomizable

public protocol MCCollectionViewFlowLayoutCustomizable {
    func sectionInset(_ layout: UICollectionViewLayout, for section: Int) -> UIEdgeInsets
    func minimumLineSpacing(_ layout: UICollectionViewLayout, for section: Int) -> CGFloat
    func minimumInteritemSpacing(_ layout: UICollectionViewLayout, for section: Int) -> CGFloat
}

extension MCCollectionViewFlowLayoutCustomizable {
    public func sectionInset(_ layout: UICollectionViewLayout, for section: Int) -> UIEdgeInsets {
        (layout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    public func minimumLineSpacing(_ layout: UICollectionViewLayout, for section: Int) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
    }

    public func minimumInteritemSpacing(_ layout: UICollectionViewLayout, for section: Int) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
    }
}

