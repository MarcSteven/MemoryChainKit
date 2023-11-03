//
//  BindableTapGestureRecognizer.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/11/29.
//  Copyright © 2021 Marc Steven(https://https://github.com/MarcSteven). All rights reserved.
//

import UIKit


// a tap gesture recognizer works with closure
public class BindableTapGestureRecognizer:UITapGestureRecognizer {
    typealias Action = (_ sender:BindableTapGestureRecognizer) ->Void
    let action:Action
    init(action:@escaping Action) {
        self.action = action
        super.init(target: nil , action: nil)
        addTarget(self, action: #selector(handleAction))
    }
    @objc
    private func handleAction() {
        action(self)
    }
}
