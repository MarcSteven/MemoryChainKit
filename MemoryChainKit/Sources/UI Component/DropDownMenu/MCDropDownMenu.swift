//
//  MCDropDownMenu.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
//MCDropdown view delegate method
public protocol MCDropdownViewDelegate:AnyObject {
    //将要展示
    func dropDownViewWillShow(_ dropdownView:MCDropdownView)
    //已经展示
    func dropdownViewDidShow(_ dropdownView:MCDropdownView)
    //将要消失
    func dropDownViewWillDismiss(_ dropdownView:MCDropdownView)
    //已经消失
    func dropdownViewDidDismiss(_ dropdownView:MCDropdownView)
    
}

open class MCDropdownView {
    // MARK: PROPERTIES
    
    /// 容器视图的封闭比例。 将其设置为1可禁用容器缩放动画
    public var closedScale: Double = 0.85 {
        didSet {
            closedScale = min(max(closedScale, 0.1), 1)
        }
    }
    
   ///布尔值表示容器视图是否应该模糊。 默认为true。
    public var shouldBlurContainerView: Bool = true
    
    ///容器视图的模糊半径。
    public var blurRadius: Double = 5.0
    
    ///黑色蒙版按钮的alpha。
    public var blackMaskAlpha: Double = 0.5 {
        didSet {
            blackMaskAlpha = min(max(blackMaskAlpha, 0), 0.9)
        }
    }
    
    /// 动画间隔
    public var animationDuration: Double = 0.5
    
    /// 内容视图的动画反弹高度。
    public var animationBounceHeight: Double = 20.0
    
    /// 动画方向
    public var direction: MCDropDownDirection = .top
    
    /// 内容背景色
    public var contentBackgroundColor: UIColor?
    
    /// 当前的下拉状态
    public private(set) var currentState: MCDropDownState = .didClose
    
    /// 一个布尔值来提示下拉菜单是否打开
    public var isOpen: Bool {
        return currentState == .didOpen
    }
    
    /// 下拉视图delegate
    public weak var delegate: MCDropdownViewDelegate?
    
    /// 下拉菜单已经显示后的回调
    public var didShowHandler: (() -> Void)?
    
    /// 下拉菜单消失后的回调
    public var didHideHandler: (() -> Void)?
    
    /// 默认动画反弹比例常数
    let defaultAnimationBounceScale = 0.05
    
    ///视图结构
    var mainView: UIScrollView
    var contentWrapperView: UIView
    var containerWrapperView: UIImageView
    var backgroundButton: UIButton
    var originContentCenter: CGPoint = .zero
    var desContentCenter: CGPoint = .zero
    var lastOrientation: UIInterfaceOrientation
    
    // MARK: 初始化
    
    public init() {
        mainView = UIScrollView()
        mainView.backgroundColor = .black
        
        contentWrapperView = UIView()
        
        containerWrapperView = UIImageView()
        containerWrapperView.backgroundColor = .black
        containerWrapperView.contentMode = .center
        
        lastOrientation = UIApplication.shared.statusBarOrientation
        
        backgroundButton = UIButton(type: .custom)
        backgroundButton.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchUpInside)
        
        // Notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: 显示
    public func show(_ contentView: UIView, inView containerView: UIView, origin: CGPoint) {
        guard currentState == .didClose else { return }
        
        // 开始展示
        currentState = .willOpen
        delegate?.dropDownViewWillShow(self)
        
        // 将菜单放在view中
        setup(contentView: contentView, inView: containerView, origin: origin)
        
        // 给对应的content增加对应的动画
        addContentAnimation(forState: currentState)
        
        // 动画内容视图控制器
        if closedScale < 1 {
            addContainerAnimation(forState: currentState)
        }
        
        // 完成展示
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.currentState = .didOpen
            self.delegate?.dropdownViewDidShow(self)
            if let handler = self.didShowHandler {
                handler()
            }
        }
    }
    //展示
    public func show(_ contentView: UIView, inView containerView: UIView, atView: UIView) {
        let origin = CGPoint(x: atView.frame.minX, y: atView.frame.maxY)
        show(contentView, inView: containerView, origin: origin)
    }
    
    public func show(_ contentView: UIView, inNavigationController navigationController: UINavigationController?) {
        guard let containerView = navigationController?.visibleViewController?.view else { return }
        show(contentView, inView: containerView, origin: .zero)
    }
    //MARK: - 隐藏
    public func hide() {
        guard currentState == .didOpen else { return }
        
        // 开始消失
        currentState = .willClose
        delegate?.dropDownViewWillDismiss(self)
        
        // 动画菜单视图控制器
        addContentAnimation(forState: currentState)
        
        // 动画目录视图控制器
        if closedScale < 1 {
            addContainerAnimation(forState: currentState)
        }
        
        // 完成隐藏
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.currentState = .didClose
            self.delegate?.dropdownViewDidDismiss(self)
            if let handler = self.didHideHandler {
                handler()
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.mainView.alpha = 0
            }, completion: { (finished) in
                self.mainView.alpha = 1
                self.forceHide()
            })
        }
    }
    
    public func forceHide() {
        currentState = .didClose
        
        let point = contentPositionValues(forState: currentState).last
        contentWrapperView.layer.setValue(point, forKeyPath: "position")
        contentWrapperView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        contentWrapperView.removeFromSuperview()
        
        backgroundButton.removeFromSuperview()
        
        let transform = containerTransformValues(forState: currentState).last
        containerWrapperView.layer.setValue(transform, forKeyPath: "transform")
        containerWrapperView.removeFromSuperview()
        
        mainView.removeFromSuperview()
    }
}

// MARK: - add views
extension MCDropdownView {
    
    public func setup(contentView: UIView, inView containerView: UIView, origin: CGPoint) {
        
        // Prepare container captured image
        let containerSize = containerView.bounds.size
        let scale = 3 - 2 * closedScale
        let capturedSize = CGSize(width: Double(containerSize.width) * scale, height: Double(containerSize.height) * scale)
        guard var capturedImage = UIImage.screenshot(fromView: containerView, size: capturedSize) else { return }
        if shouldBlurContainerView {
            capturedImage = capturedImage.blurred(withRadius: CGFloat(blurRadius))
        }
        
        // 主视图
        mainView.frame = containerView.bounds
        containerView.addSubview(mainView)
        
        // 容器交换视图
        containerWrapperView.image = capturedImage
        containerWrapperView.bounds = CGRect(x: 0, y: 0, width: capturedSize.width, height: capturedSize.height)
        containerWrapperView.center = mainView.center
        mainView.addSubview(containerWrapperView)
        
        // Background Button
        let maskColor = UIColor.black.withAlphaComponent(CGFloat(blackMaskAlpha))
        backgroundButton.backgroundColor = maskColor
        backgroundButton.frame = mainView.bounds
        mainView.addSubview(backgroundButton)
        
        // Content Wrapper View
        contentWrapperView.backgroundColor = contentBackgroundColor
        let contentWrapperViewHeight = Double(contentView.frame.size.height) + animationBounceHeight;
        switch direction {
        case .top:
            contentView.frame = CGRect(x: 0,
                                       y: CGFloat(animationBounceHeight),
                                       width: contentView.frame.size.width,
                                       height: contentView.frame.size.height)
            contentWrapperView.frame = CGRect(x: origin.x,
                                              y: origin.y - CGFloat(contentWrapperViewHeight),
                                              width: contentView.frame.size.width,
                                              height: CGFloat(contentWrapperViewHeight));
        case .bottom:
            contentView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: contentView.frame.size.width,
                                       height: contentView.frame.size.height)
            contentWrapperView.frame = CGRect(x: origin.x,
                                              y: origin.y + CGFloat(contentWrapperViewHeight),
                                              width: contentView.frame.size.width,
                                              height: CGFloat(contentWrapperViewHeight));
        }
        contentWrapperView.addSubview(contentView)
        mainView.addSubview(contentWrapperView)
        
        // Set up origin, destination content center
        originContentCenter = CGPoint(x: contentWrapperView.frame.midX, y: contentWrapperView.frame.midY)
        if (direction == .top) {
            desContentCenter = CGPoint(x: contentWrapperView.frame.midX,
                                       y: origin.y + CGFloat(contentWrapperViewHeight)/2 - CGFloat(animationBounceHeight))
        }
        else {
            desContentCenter = CGPoint(x: contentWrapperView.frame.midX,
                                       y: origin.y + CGFloat(contentWrapperViewHeight)/2)
        }
    }
    
    @objc func backgroundButtonTapped() {
        hide()
    }
    //方向改变
    @objc func orientationChanged(notification: Notification) {
        let currentOrientation = UIApplication.shared.statusBarOrientation
        let canForceHide = (currentOrientation.isPortrait && lastOrientation.isLandscape)
            || (lastOrientation.isPortrait && currentOrientation.isLandscape)
        if canForceHide {
            delegate?.dropDownViewWillDismiss(self)
            forceHide()
            delegate?.dropdownViewDidDismiss(self)
            
            if let handler = self.didHideHandler {
                handler()
            }
        }
        
        lastOrientation = currentOrientation
    }
}

