//
//  UIView+DisplayInformationTipView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/15.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UIView {
    
    @objc func displayInfoTipView(identifier: String, title: String? = nil, message: String, button: String? = nil, arrowPosition: MCInformationTipView.MCArrowPosition, preferences: MCInformationTipPreferences = MCInformationTipPreferences(), delegate: MCInformationTipViewDelegate? = nil) {
        let informationTipView = MCInformationTipView(view: self, identifier: identifier, title: title, message: message, button: button, arrowPostion: arrowPosition, preferences: preferences, delegate: delegate)
        informationTipView.calculateFrame()
        informationTipView.show()
        
    }
    
}
