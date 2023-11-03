//
//  MCTabBarButton.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/28.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public class MCTabBarButton: UIButton {
    var selectedColor:UIColor! = .black {
        didSet {
            reloadAppearance()
        }
    }
    var unselectedColor:UIColor!  = UIColor(hexString: "0x9b9b9b") {
        didSet {
            reloadAppearance()
        }
    }
    init(forItem item:UITabBarItem) {
        super.init(frame: .zero)
        setImage(item.image, for: .normal)
    }
    init(image:UIImage) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override public var isSelected: Bool {
        didSet {
            reloadAppearance()
        }
    }
    func reloadAppearance() {
        self.tintColor = isSelected ? selectedColor : unselectedColor
    }

}
