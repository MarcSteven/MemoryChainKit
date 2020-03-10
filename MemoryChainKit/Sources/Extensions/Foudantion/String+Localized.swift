//
//  String+Localized.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/31.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension String {
    var localized:String {
        
        return NSLocalizedString(self,comment:"")
    }
}
//Localization
