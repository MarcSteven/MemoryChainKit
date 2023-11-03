//
//  EventHandler.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol EventHandler:AnyObject {
    func handle(_ event:Event)
}
