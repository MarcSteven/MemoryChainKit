//
//  UIResponderExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/10.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIResponder {
    func responderChain() ->String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + "->" + next.responderChain()
    }
}

extension UIResponder {
    
    /**
     
     /// ```swift
        /// extension UICollectionViewCell {
        ///     func configure() {
        ///         if let collectionView = responder() as? UICollectionView {
        ///
        ///         }
        ///     }
        /// }
        /// ```
     
     */
    open func responder<T:UIResponder>() ->T? {
        var responder :UIResponder = self
        while let nextResponder = responder.nextResponder {
            responder = nextResponder
            if responder is T {
                return responder as? T
            }
        }
        return nil
    }
}
