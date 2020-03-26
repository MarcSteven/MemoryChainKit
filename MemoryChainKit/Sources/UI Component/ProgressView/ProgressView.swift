//
//  ProgressView.swift
//  TooLow
//
//  Created by Marc Steven on 2019/3/26.
//  Copyright © 2019-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

final public class ProgressView: MCView {
    private var heightConstraint: NSLayoutConstraint?
    private let progressLayer = CAShapeLayer()

    @objc dynamic public var progressTintColor: UIColor = .white {
        didSet {
            progressLayer.strokeColor = progressTintColor.cgColor
        }
    }

    @objc dynamic public var fillHeight: CGFloat = 1 {
        didSet {
            heightConstraint?.constant = fillHeight
        }
    }

    @objc dynamic public var progressHeight: CGFloat = 2 {
        didSet {
            progressLayer.lineWidth = progressHeight
        }
    }

    public override var isHidden: Bool {
        didSet {
            setupAnimation()
        }
    }

    public override func commonInit() {
        layer.addSublayer(progressLayer)
        progressLayer.strokeColor = progressTintColor.cgColor
        progressLayer.lineWidth = progressHeight
        backgroundColor = progressTintColor.alpha(progressTintColor.alpha * 0.2)
        anchor.make {
            heightConstraint = $0.height.equalTo(fillHeight).constraints.first
        }
        setupAnimation()
    }

    private func setupAnimation() {
        progressLayer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "strokeEnd").apply {
            $0.fromValue = 0
            $0.toValue = 1
            $0.repeatCount = .greatestFiniteMagnitude
            $0.isRemovedOnCompletion = false
            $0.duration = 3
        }
        progressLayer.add(animation, forKey: "progress")
    }

    private func setupPath() {
        let path = CGMutablePath()
        let y = progressHeight / 2
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: bounds.width, y: y))
        progressLayer.path = path
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds
        setupPath()
    }
}
