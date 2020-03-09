//
//  RoundedView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/10/1.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

@IBDesignable

public class RoundedView:UIView {
    public override class var layerClass:AnyClass {
        return CAShapeLayer.self
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    private func setupLayer() {
        self.layer.cornerRadius = 11
        self.layer.masksToBounds = true
    }
}
