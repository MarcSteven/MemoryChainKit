//
//  Analytics.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

open class Analytics<Event:AnalyticsEvent> {
    
    open private(set) var providers:[AnalyticsProvider] = []
    public init() {}
    
    // register provider to ensure there are no duplicate providers
    open func register(_ provider:AnalyticsProvider) {
        guard !providers.contains(where: {$0.id == provider.id}) else {
            return
        }
        providers.append(provider)
    }
    open func track(_ event:Event) {
        let providers = finalProviders(additionalProviders: event.additonalProviders)
        providers.forEach {
            $0.track(event)
            
        }
    }
    private func finalProviders(additionalProviders: [AnalyticsProvider]? = nil) -> [AnalyticsProvider] {
        guard let additionalProviders = additionalProviders, !additionalProviders.isEmpty else {
            return providers
        }

        var providers = self.providers

        for provider in additionalProviders where !providers.contains(where: { $0.id == provider.id }) {
            providers.append(provider)
        }

        return providers
    }

}
