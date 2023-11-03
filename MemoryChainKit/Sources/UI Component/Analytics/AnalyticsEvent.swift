//
//  AnalyticsEvent.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public protocol AnalyticsEvent {
    var name:String {get}
    var properties:[String:Any]? {get}
    var additonalProviders:[AnalyticsProvider]? {get}
    
}
