//
//  NotificationName.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/13.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol NotificationName {
    var name:Notification.Name {get }
}
extension RawRepresentable where RawValue == String, Self:NotificationName {
    var name:Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }
}
