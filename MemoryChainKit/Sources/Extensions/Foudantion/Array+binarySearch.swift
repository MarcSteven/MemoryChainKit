//
//  Array+binarySearch.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public extension Array {
     func binarySearch<T>(target: T, transform: (Element) -> T, _ comparison: (T, T) -> ComparisonResult) -> Int? {
        var localRange = 0..<count

        while localRange.startIndex < localRange.endIndex {
            // Find the middle point in the array within the given range
            let midIndex: Int = localRange.startIndex + (localRange.endIndex - localRange.startIndex) / 2
            let comparableObject = transform(self[midIndex])
            let result = comparison(comparableObject, target)
            switch result {
                case .orderedSame:
                    // If we found our search key, return the index
                    return midIndex
                case .orderedAscending:
                    // If the middle value is less than the target, look at the right half
                    localRange = (midIndex + 1)..<localRange.endIndex
                case .orderedDescending:
                    // If the midle value is greater than the target, look at the left half
                    localRange = localRange.startIndex..<midIndex
            }
        }
        return nil
    }
}
