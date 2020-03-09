//
//  setupView.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/15.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

typealias view = UIView
internal class SetupView: view {
    //Subclass should override setup instead of any of the initializers,subclassers must call super.setup()
    open func setupView() {
        
    }
    open func setupConstraints() {
        
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
}
