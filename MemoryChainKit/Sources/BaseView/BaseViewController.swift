//
//  BaseViewController.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/11.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit


open class BaseViewController<T:UIView>:UIViewController {
    let root = T()
    
    open override func loadView() {
        view = root
    }
}
