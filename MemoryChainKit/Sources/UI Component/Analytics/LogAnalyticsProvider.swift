//
//  LogAnalyticsProvider.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public struct LogAnalyticsProvier:AnalyticsProvider {
    public init() {}
    public func track(_ event: AnalyticsEvent) {
        let (enabled,containsValue) = ProcessInfo.Arguments.isAnalyticsDebugEnabled
        guard enabled else {return }
        if let value = containsValue {
            if event.name.contains(value) {
                log(event)
            }
        }else {
            log(event)
        }
        
    }
    private func log(_ event:AnalyticsEvent) {
        var propertiesString = ""
        if let properties = event.properties,
            !properties.isEmpty {
            propertiesString = JSONUtil.stringify(properties, prettyPrinted: true)
            propertiesString = "\nproperties:\(propertiesString)"
        }
        print("""

        event: "\(event.name)"\(propertiesString)
        """)

    }
}
