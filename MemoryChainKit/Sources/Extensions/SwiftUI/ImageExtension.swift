//
//  ImageExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/8.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Image {
        init(_ name: String, defaultImage: String) {
            if let img = UIImage(named: name) {
                self.init(uiImage: img)
            } else {
                self.init(defaultImage)
            }
        }
        
        init(_ name: String, defaultSystemImage: String) {
            if let img = UIImage(named: name) {
                self.init(uiImage: img)
            } else {
                self.init(systemName: defaultSystemImage)
            }
        }
}
