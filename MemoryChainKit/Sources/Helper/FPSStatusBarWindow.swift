//
//  FPSStatusBarWindow.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/10/30.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//



import UIKit


class FPStatusBarWindow: UIWindow {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // don't hijack touches from the main window
        return false
    }
}
