//
//  UIResponderExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/10.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIResponder {
    func responderChain() ->String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + "->" + next.responderChain()
    }
}
