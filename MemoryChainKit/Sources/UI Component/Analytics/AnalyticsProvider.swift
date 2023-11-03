//
//  AnalyticsProvider.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public protocol AnalyticsProvider {
    var id:String {get}// a unique id for analytic provider
    func track(_ event:AnalyticsEvent)
}

extension AnalyticsProvider {
    public var id:String {
        name(of: self)
    }
}
