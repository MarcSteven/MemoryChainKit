//
//  DeviceVersion.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import RxSwift

import Foundation
import UIKit
public struct DeviceVersion {
    static let system_version_float = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (DeviceVersion.system_version_float < 8.0 && DeviceVersion.system_version_float >= 7.0)
    static let iOS8 = (DeviceVersion.system_version_float >= 8.0 && DeviceVersion.system_version_float < 9.0)
    static let iOS9 = (DeviceVersion.system_version_float >= 9.0 && DeviceVersion.system_version_float < 10.0)
    static let iOS10 = (DeviceVersion.system_version_float >= 10.0 && DeviceVersion.system_version_float <= 11.0)
    static let iOS11 = (DeviceVersion.system_version_float >= 11.0 && DeviceVersion.system_version_float <= 12.0)
    static let iOS12 = (DeviceVersion.system_version_float >= 12.0 && DeviceVersion.system_version_float <= 13.0)
    static let iOS13 = (DeviceVersion.system_version_float >= 13.0 && DeviceVersion.system_version_float <= 14.0)
}
