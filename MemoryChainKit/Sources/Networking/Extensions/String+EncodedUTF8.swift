//
//  String+EncodedUTF8.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension String {
        func encodeUTF8() -> String? {
            if let _ = URL(string: self) {
                return self
            }

            var components = self.components(separatedBy: "/")
            guard let lastComponent = components.popLast(),
                let endcodedLastComponent = lastComponent.addingPercentEncoding(withAllowedCharacters: .urlQueryParametersAllowed) else {
                return nil
            }

            return (components + [endcodedLastComponent]).joined(separator: "/")
        }

    }
    

