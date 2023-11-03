//
//  ImageTitleDisplayable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/3.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol ImageTitleDisplayable {
    var title: StringRepresentable { get }
    var subtitle: StringRepresentable? { get }
    
}

extension ImageTitleDisplayable {
    public var subtitle: StringRepresentable? {
        nil
    }
}
