//
//  LocaleExtension.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/11/29.
//  Copyright © 2021 Marc Steven(https://https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Locale {
    func use24hClock() ->Bool {
        let formatter = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: self) ?? ""
        return !formatter.contains("a")
    }
}
