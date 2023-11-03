//
//  PublisherExtension.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/12/22.
//  Copyright © 2021 Marc Steven(https://.com/MarcSteven). All rights reserved.
//

import UIKit

import Combine

@available(iOS 13.0, *)
public extension Publisher where Self.Output == String,Self.Failure == Never {
    func setTitle(on button:UIButton,state:UIControl.State) ->AnyCancellable {
        sink { title in
            button.setTitle(title, for: state)
            
        }
    }
}
