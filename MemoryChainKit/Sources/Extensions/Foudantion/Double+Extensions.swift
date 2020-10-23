//
//  Double+Extensions.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/3.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension Double {
    var km:Double {
        return self * 1_000.0
    }
    var m:Double {
        return self
    }
    var cm:Double {
        return self / 100.0
    }
    var mm:Double {
        return self / 1_000.0
    }
    var ft:Double {
        return self / 3.28084
    }
    func toString() -> String {
        String(format: "%.02f", self)
    }
    func toPrice(currency: String) -> String {
        let nf = NumberFormatter()
        nf.decimalSeparator = ","
        nf.groupingSeparator = "."
        nf.groupingSize = 3
        nf.usesGroupingSeparator = true
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return (nf.string(from: NSNumber(value: self)) ?? "?") + currency
    }
}
