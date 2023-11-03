//
//  CardTabBarController.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/7/29.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

open class CardTabBarController: UITabBarController {
    
    
    @IBInspectable public var tintColor: UIColor? {
        didSet {
            customTabBar.tintColor = tintColor
            customTabBar.reloadApperance()
        }
    }
    
    @IBInspectable public var tabBarBackgroundColor: UIColor? {
        didSet {
            customTabBar.backgroundColor = tabBarBackgroundColor
            customTabBar.reloadApperance()
        }
    }
    
    lazy var customTabBar: CardTabBar = {
        return CardTabBar()
    }()
    
    fileprivate lazy var smallBottomView: UIView = {
        let anotherSmallView = UIView()
        anotherSmallView.backgroundColor = .clear
        anotherSmallView.translatesAutoresizingMaskIntoConstraints = false

        return anotherSmallView
    }()
    
    override open var selectedIndex: Int {
        didSet {
            customTabBar.select(at: selectedIndex, hasNotifyDelegate: false)
            //customTabBar.select(at: selectedIndex, hasn: false)
        }
    }

    override open var selectedViewController: UIViewController? {
        didSet {
            customTabBar.select(at: selectedIndex, hasNotifyDelegate: false)
        }
    }
    
    fileprivate var bottomSpacing: CGFloat = 20
    fileprivate var tabBarHeight: CGFloat = 70
    fileprivate var horizontleSpacing: CGFloat = 20
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight + bottomSpacing, right: 0)
        }
        
        
        self.tabBar.isHidden = true

        addAnotherSmallView()
        setupTabBar()
        
        customTabBar.items = tabBar.items!
        customTabBar.select(at: selectedIndex)
    }
    
    fileprivate func addAnotherSmallView(){
        self.view.addSubview(smallBottomView)
        
        smallBottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        let cr: NSLayoutConstraint
        
        if #available(iOS 11.0, *) {
            cr = smallBottomView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: tabBarHeight)
        } else {
            cr = smallBottomView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: tabBarHeight)
        }
        
        cr.priority = .defaultHigh
        cr.isActive = true
        
        smallBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        smallBottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupTabBar(){
        customTabBar.delegate = self
        self.view.addSubview(customTabBar)
        
        customTabBar.bottomAnchor.constraint(equalTo: smallBottomView.topAnchor, constant: 0).isActive = true
        customTabBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        customTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontleSpacing).isActive = true
        customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        
        self.view.bringSubviewToFront(customTabBar)
        self.view.bringSubviewToFront(smallBottomView)
        
        customTabBar.tintColor = tintColor
    }
}

extension CardTabBarController: CardTabBarDelegate {
    func cardTabBar(_ sender: CardTabBar, didSelectItemAt index: Int) {
        self.selectedIndex = index
    }
}
