//
//  CardTabBar.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/7/28.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

protocol CardTabBarDelegate:AnyObject {
    func cardTabBar(_ sender:CardTabBar,
                    didSelectItemAt index:Int)
}

open class CardTabBar: UIView {
    weak var delegate:CardTabBarDelegate?
    
    var items:[UITabBarItem] = [] {
        didSet {
            reloadViews()
        }
    }
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    lazy var indicatorView: IndicatorView = {
        let view = IndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constraint(width: 5)
        view.backgroundColor = tintColor
        view.makeWidthEqualHeight()
        return view
    }()
    private var indicatorViewYConstraint:NSLayoutConstraint!
    private var indicatorViewXConstraint:NSLayoutConstraint!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(indicatorView)
        
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.15
        
        indicatorViewYConstraint?.isActive = false
        indicatorViewYConstraint = indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10.5)
        indicatorViewYConstraint.isActive = true
        tintColorDidChange()
        
    }
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        reloadApperance()
    }
    func add(item:UITabBarItem) {
        self.items.append(item)
        
    }
    func reloadApperance() {
        buttons().forEach {button in
            button.selectedColor = tintColor
        }
    }
    func reloadViews() {
        indicatorViewYConstraint?.isActive = false
                indicatorViewYConstraint = indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10.5)
                indicatorViewYConstraint.isActive = true
                
                
                for button in (stackView.arrangedSubviews.compactMap { $0 as? MCTabBarButton }) {
                    stackView.removeArrangedSubview(button)
                    button.removeFromSuperview()
                    button.removeTarget(self, action: nil, for: .touchUpInside)
                }
                
                for item in items {
                    if let image = item.image {
                        addButton(image)
                    } else {
                        addButton(UIImage())
                    }
                }
                
                select(at: 0)
        
    }
   public func select(at index:Int,
                hasNotifyDelegate:Bool = true ) {
        for(bIndex,view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.tintColor = bIndex == index ? tintColor : UIColor(rgb: 0x9b9b9b)
            }
        }
        if hasNotifyDelegate {
            self.delegate?.cardTabBar(self, didSelectItemAt: index)
        }
    }
    private func addButton(_ image:UIImage) {
        let button = MCTabBarButton(image:image)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.selectedColor = tintColor
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        self.stackView.addArrangedSubview(button)
    }
    func select(at index:Int) {
        if indicatorViewXConstraint != nil {
            indicatorViewXConstraint.isActive = false
            indicatorViewXConstraint = nil
        }
        for(bIndex,button) in buttons().enumerated() {
            button.selectedColor = tintColor
            button.isSelected = bIndex == index
            if bIndex == index {
                indicatorViewXConstraint = indicatorView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
                indicatorViewXConstraint.isActive = true
            }
        }
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        self.delegate?.cardTabBar(self, didSelectItemAt: index)
    }
    @objc func buttonTapped(sender:MCTabBarButton) {
        if let index = stackView.arrangedSubviews.firstIndex(of: sender) {
            select(at: index)
        }
    }
    private func buttons() ->[MCTabBarButton] {
        return stackView.arrangedSubviews.compactMap{$0 as? MCTabBarButton}
    }
    deinit {
        stackView.arrangedSubviews.forEach {
            if let button = $0 as? UIControl {
                button.removeTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            }
        }
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else {
            superview?.touchesEnded(touches, with: event)
            return
        }
        let buttons = self.stackView.arrangedSubviews.compactMap {$0 as? MCTabBarButton}.filter {!$0.isHidden}
        let distances = buttons.map {$0.center.distance(to: position)}
        let buttonDistance = zip(buttons, distances)
        if let closesButton = buttonDistance.min(by:{$0.1 < $1.1}) {
            buttonTapped(sender: closesButton.0)
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        layer.cornerRadius = bounds.height / 2
    }


}
