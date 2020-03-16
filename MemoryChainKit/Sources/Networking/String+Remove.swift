//
//  String+Remove.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension String {
    mutating func removeFirstLetterIfDash() {
        let initialCharacter = String(self[..<index(after: startIndex)])
        if initialCharacter == "/" {
            if count > 1 {
                remove(at: startIndex)
            }else {
                self = ""
            }
        }
    }
    mutating func removeLastLetterIfDash() {
        let initialCharacter:String
        if count > 1 {
                initialCharacter = String(self[index(endIndex, offsetBy: -1)...])
            } else {
                initialCharacter = String(self[..<endIndex])
            }

            if initialCharacter == "/" {
                if count > 1 {
                    remove(at: index(endIndex, offsetBy: -1))
                } else {
                    self = ""
                }
            }
        }
    }

