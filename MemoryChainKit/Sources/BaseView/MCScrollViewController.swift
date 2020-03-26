//
//  MCScrollViewController.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/26.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


open class MCScrollViewController:UIViewController {
    public let scrollView = UIScrollView()
    
    //MARK: - view lifeCycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.anchor.edges.equalToSuperView()
        
    }
    private func resolveContentSize() {
        scrollView.resolve(axis:.vertical,fixedView:view)
    }
}
