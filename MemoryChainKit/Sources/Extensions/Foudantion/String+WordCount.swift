//
//  String+WordCount.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation



//MARK: - method

public extension String {
    func replacingOccurrences(of search:String, with replacement:String,count maxReplacement :Int) ->String {
        var count = 0
        var returnValue = self
        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1
            if count  == maxReplacement {
                return  returnValue
            }
        }
        return returnValue
    }
}
