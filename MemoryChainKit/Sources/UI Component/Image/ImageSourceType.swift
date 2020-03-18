//
//  ImageSourceType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public enum ImageSourceType:Equatable {
    case url(String),image(UIImage)
    var isValid:Bool {
        switch self {
        case .image:
            return true
        case .url(let value):
            return !value.isBlank
                }
    }
    public var isRemoteURL:Bool {
        guard case .url(let rawValue) = self,
        let url = URL(string: rawValue),
            url.host != nil
        else {
            return false
        }
        return true
    }
}
extension ImageSourceType {
    public enum CacheType {
        case none,disk,memory
        var possiblyDelayed:Bool {
            return self != .memory
        }
    }
}
