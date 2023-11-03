//
//  BundleExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/7.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public  extension Bundle {
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }

    static var appDisplayName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var appBuildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
