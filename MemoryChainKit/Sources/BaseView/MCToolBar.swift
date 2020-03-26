//
//  MCToolBar.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/26.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

open class MCToolbar: UIToolbar {
    /// The default value is `44` (system's standard).
    open var preferredHeight: CGFloat = 44 {
        didSet {
            guard oldValue != preferredHeight else { return }
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    // MARK: - Init Methods

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Setup Methods

    /// The default implementation of this method does nothing.
    ///
    /// Subclasses can override it to perform additional actions, for example, add
    /// new subviews or configure properties. This method is called when `self` is
    /// initialized using any of the relevant `init` methods.
    open func commonInit() {}

    // MARK: - Override Methods

    open override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = preferredHeight
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = preferredHeight
        return size
    }

    open override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: preferredHeight)
    }
}

