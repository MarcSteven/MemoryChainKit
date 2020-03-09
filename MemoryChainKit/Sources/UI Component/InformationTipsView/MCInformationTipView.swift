//
//  MCInformationTipView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/15.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import Darwin

@objc public protocol MCInformationTipViewDelegate:class {
    func informationTipsViewDidAppear( for identifier:String)
    func informationTipViewDidDisappear( for identifier:String,with timeInterval:TimeInterval)
}

open class MCInformationTipView :UIView {
    @objc public enum MCArrowPosition:Int {
        case top,right,bottom,left
        
    }
    //MARK: - private variable
    private var arrowPosition:MCArrowPosition = .top
    private var bubbleFrame:CGRect = .zero
    private var containerWindow:UIWindow?
    private unowned var presentingView:UIView
    
    private var identifer:String
    private var title:String?
    private var message:String
    private var button:String?
    
    private weak var delegate:MCInformationTipViewDelegate?
    private var theTimeOfViewDidAppear:Date = Date()
    private var preferences:MCInformationTipPreferences
    
    //MARK: - lazy  variables
    
    private lazy var gradient:CGGradient = { [unowned self] in
        
        let colors = self.preferences.drawing.bubble.gradientColors.map { $0.cgColor} as CFArray
        let locations = self.preferences.drawing.bubble.gradientLocations
        return CGGradient(colorsSpace: nil, colors: colors, locations: locations)!
    }()
    private lazy var titleSize:CGSize = {
        [unowned self] in
        var attributes = [NSAttributedString.Key.font:self.preferences.drawing.title.font]
        var textSize:CGSize = CGSize.zero
        if self.title != nil {
            textSize = self.title!.boundingRect(with: CGSize(width: self.preferences.drawing.bubble.maxWidth - self.preferences.drawing.bubble.inset * 2, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        }
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        return textSize
    }()
    private lazy var messageSize:CGSize = {[unowned self] in
        
        var attributes = [NSAttributedString.Key.font:self.preferences.drawing.message.font]
        
         var textSize = self.message.boundingRect(with: CGSize(width: self.preferences.drawing.bubble.maxWidth - self.preferences.drawing.bubble.inset * 2, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
    }()
    private lazy var buttonSize: CGSize = { [unowned self] in
        var attributes = [NSAttributedString.Key.font : self.preferences.drawing.button.font]
        
        var textSize = CGSize.zero
        if self.button != nil {
            textSize = self.button!.boundingRect(with: CGSize(width: self.preferences.drawing.bubble.maxWidth - self.preferences.drawing.bubble.inset * 2, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        }
        
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        
        return textSize
        }()
    
    private lazy var bubbleSize: CGSize = { [unowned self] in
        var height = self.preferences.drawing.bubble.inset
        
        if self.title != nil {
            height += self.titleSize.height + self.preferences.drawing.bubble.spacing
        }
        
        height += self.messageSize.height
        
        if self.button != nil {
            height += self.preferences.drawing.bubble.spacing + self.buttonSize.height
        }
        
        height += self.preferences.drawing.bubble.inset
        
        let widthInset = self.preferences.drawing.bubble.inset * 2
        let width = min(self.preferences.drawing.bubble.maxWidth, max(self.titleSize.width + widthInset, self.messageSize.width + widthInset))
        return CGSize(width: width, height: height)
        }()
    
    private lazy var contentSize: CGSize = { [unowned self] in
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        switch self.arrowPosition {
        case .top, .bottom:
            height = self.preferences.drawing.arrow.size.height + self.bubbleSize.height
            width = self.bubbleSize.width
        case .right, .left:
            height = self.bubbleSize.height
            width = self.preferences.drawing.arrow.size.height + self.bubbleSize.width
        }
        
        return CGSize(width: width, height: height)
        }()
    
    //MARK: - initilizer
    init(view:UIView,
         identifier:String,
         title:String? = nil,
         message:String,
         button:String? = nil,
         arrowPostion:MCArrowPosition,
         preferences:MCInformationTipPreferences,
         delegate:MCInformationTipViewDelegate? = nil) {
        self.presentingView = view
        self.identifer = identifier
        self.title = title
        self.message = message
        self.arrowPosition = arrowPostion
        self.preferences = preferences
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - gesture methos
    @objc func handleTapGesture() {
        dismissWithAnimation()
    }
    // MARK:  methods
    
   open  func calculateFrame() {
        let refViewFrame = presentingView.convert(presentingView.bounds, to: UIApplication.shared.keyWindow);
        
        var xOrigin: CGFloat = 0
        var yOrigin: CGFloat = 0
        
        let spacingForBorder: CGFloat = (preferences.drawing.bubble.border.color != nil) ? preferences.drawing.bubble.border.width : 0
        
        switch arrowPosition {
        case .top:
            xOrigin = refViewFrame.center.x - contentSize.width / 2
            yOrigin = refViewFrame.minY + refViewFrame.height
            preferences.drawing.arrow.tip = CGPoint(x: refViewFrame.center.x - xOrigin, y: 0)
            bubbleFrame = CGRect(x: spacingForBorder, y: preferences.drawing.arrow.size.height + spacingForBorder, width: bubbleSize.width, height: bubbleSize.height)
        case .right:
            xOrigin = refViewFrame.minX - contentSize.width
            yOrigin = refViewFrame.center.y - contentSize.height / 2
            preferences.drawing.arrow.tip = CGPoint(x: bubbleSize.width + preferences.drawing.arrow.size.height + spacingForBorder, y: refViewFrame.center.y - yOrigin)
            bubbleFrame = CGRect(x: spacingForBorder, y: spacingForBorder, width: bubbleSize.width, height: bubbleSize.height)
        case .bottom:
            xOrigin = refViewFrame.center.x - contentSize.width / 2
            yOrigin = refViewFrame.minY - contentSize.height
            preferences.drawing.arrow.tip = CGPoint(x: refViewFrame.center.x - xOrigin, y: bubbleSize.height + preferences.drawing.arrow.size.height)
            bubbleFrame = CGRect(x: spacingForBorder, y: spacingForBorder, width: bubbleSize.width, height: bubbleSize.height)
        case .left:
            xOrigin = refViewFrame.minX + refViewFrame.width
            yOrigin = refViewFrame.center.y - contentSize.height / 2
            preferences.drawing.arrow.tip = CGPoint(x: spacingForBorder, y: refViewFrame.center.y - yOrigin)
            bubbleFrame = CGRect(x: preferences.drawing.arrow.size.height + spacingForBorder, y: spacingForBorder, width: bubbleSize.width, height: bubbleSize.height)
        }
        
        let calculatedFrame = CGRect(x: xOrigin, y: yOrigin, width: contentSize.width + spacingForBorder * 2, height: contentSize.height + spacingForBorder * 2)
        frame = adjustFrame(calculatedFrame)
    }
    
    private func adjustFrame(_ frame: CGRect) -> CGRect {
        let bounds = UIScreen.main.bounds
        let restrictedBounds = CGRect(x: bounds.minX + preferences.drawing.bubble.inset, y: bounds.minY + preferences.drawing.bubble.inset, width: bounds.width - preferences.drawing.bubble.inset * 2, height: bounds.height - preferences.drawing.bubble.inset * 2)
        
        if !restrictedBounds.contains(frame) {
            var newFrame = frame
            
            if frame.minX < restrictedBounds.minX {
                let diff = -frame.minX + preferences.drawing.bubble.inset
                newFrame.x = frame.x + diff
                if arrowPosition == .top || arrowPosition == .bottom {
                    preferences.drawing.arrow.tip.x = max(preferences.drawing.arrow.size.width, preferences.drawing.arrow.tip.x - diff)
                }
            }
            
            if frame.minX + frame.width > restrictedBounds.minX + restrictedBounds.width {
                let diff = frame.minX + frame.width - restrictedBounds.minX - restrictedBounds.width
                newFrame.x = frame.x - diff
                if arrowPosition == .top || arrowPosition == .bottom {
                    preferences.drawing.arrow.tip.x = min(newFrame.width - preferences.drawing.arrow.size.width, preferences.drawing.arrow.tip.x + diff)
                }
            }
            
            return newFrame
        }
        
        return frame
    }
    
   open  func show() {
        let viewController = UIViewController()
        viewController.view.alpha = 0
        viewController.view.addSubview(self)
        
        createWindow(with: viewController)
        addTapGesture(for: viewController)
        showWithAnimation()
    }
    
    private func createWindow(with viewController: UIViewController) {
        self.containerWindow = UIWindow(frame: UIScreen.main.bounds)
        self.containerWindow!.rootViewController = viewController
        self.containerWindow!.windowLevel = UIWindow.Level.alert + 1;
        self.containerWindow!.makeKeyAndVisible()
    }
    
    private func addTapGesture(for viewController: UIViewController) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        viewController.view.addGestureRecognizer(tap)
    }
    
    private func showWithAnimation() {
        transform = preferences.animating.displayInitialTransform
        alpha = preferences.animating.displayInitialAlpha
        
        UIView.animate(withDuration: preferences.animating.durationOfDisplaying, delay: 0, usingSpringWithDamping: preferences.animating.springDamping, initialSpringVelocity: preferences.animating.springVelocity, options: [.curveEaseInOut], animations: {
            self.transform = self.preferences.animating.displayFinalTransform
            self.alpha = 1
            self.containerWindow?.rootViewController?.view.alpha = 1
        }, completion: { (completed) in
            self.viewDidAppear()
        })
    }
    
    private func dismissWithAnimation() {
        UIView.animate(withDuration: preferences.animating.durationOfDismissing, delay: 0, usingSpringWithDamping: preferences.animating.springDamping, initialSpringVelocity: preferences.animating.springVelocity, options: [.curveEaseInOut], animations: {
            self.transform = self.preferences.animating.dismissTransfor
            self.alpha = self.preferences.animating.hideFinalAlpha
            self.containerWindow?.rootViewController?.view.alpha = 0
        }) { (finished) -> Void in
            self.viewDidDisappear()
            self.removeFromSuperview()
            self.transform = CGAffineTransform.identity
            self.containerWindow?.resignKey()
            self.containerWindow = nil
        }
    }
    
    override open func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        drawBackgroundLayer()
        drawBubble(context)
        drawTexts(to: context)
    }
    
    private func viewDidAppear() {
        self.theTimeOfViewDidAppear = Date()
        self.delegate?.informationTipsViewDidAppear(for: self.identifer)
        
    }
    
    private func viewDidDisappear() {
        let timeInterval = Date().timeIntervalSince(theTimeOfViewDidAppear)
       
        self.delegate?.informationTipViewDidDisappear(for: self.identifer, with: timeInterval)
    }
    
    // MARK: Drawing methods
    
    private func drawBackgroundLayer() {
        if let view = self.containerWindow?.rootViewController?.view {
            let refViewFrame = presentingView.convert(presentingView.bounds, to: UIApplication.shared.keyWindow);
            let radius = refViewFrame.center.farCornerDistance()
            let frame = view.bounds
            let layer = MCRadialGradientBackgroundLayer(frame: frame, center: refViewFrame.center, radius: radius, locations: preferences.drawing.background.gradientLocation, colors: preferences.drawing.background.gradientColor)
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func drawBubbleBorder(_ context: CGContext, path: CGMutablePath, borderColor: UIColor) {
        context.saveGState()
        context.addPath(path)
        context.setStrokeColor(borderColor.cgColor)
        context.setLineWidth(preferences.drawing.bubble.border.width)
        context.strokePath()
        context.restoreGState()
    }
    
    private func drawBubble(_ context: CGContext) {
        context.saveGState()
        let path = CGMutablePath()
        
        switch arrowPosition {
        case .top:
            let startingPoint = CGPoint(x: preferences.drawing.arrow.tip.x - preferences.drawing.arrow.size.width / 2, y: bubbleFrame.minY)
            path.move(to: startingPoint)
            addTopArc(to: path)
            addLeftArc(to: path)
            addBottomArc(to: path)
            addRightArc(to: path)
            path.addLine(to: CGPoint(x: preferences.drawing.arrow.tip.x + preferences.drawing.arrow.size.width / 2, y: bubbleFrame.minY))
            addArrowTipArc(with: startingPoint, to: path)
        case .right:
            let startingPoint = CGPoint(x: preferences.drawing.arrow.tip.x - preferences.drawing.arrow.size.height, y: preferences.drawing.arrow.tip.y - preferences.drawing.arrow.size.width / 2)
            path.move(to: startingPoint)
            addRightArc(to: path)
            addTopArc(to: path)
            addLeftArc(to: path)
            addBottomArc(to: path)
            path.addLine(to: CGPoint(x: preferences.drawing.arrow.tip.x - preferences.drawing.arrow.size.height, y: preferences.drawing.arrow.tip.y + preferences.drawing.arrow.size.width / 2))
            addArrowTipArc(with: startingPoint, to: path)
        case .bottom:
            let startingPoint = CGPoint(x: preferences.drawing.arrow.tip.x + preferences.drawing.arrow.size.width / 2, y: bubbleFrame.minY + bubbleFrame.height)
            path.move(to: startingPoint)
            addBottomArc(to: path)
            addRightArc(to: path)
            addTopArc(to: path)
            addLeftArc(to: path)
            path.addLine(to: CGPoint(x: preferences.drawing.arrow.tip.x - preferences.drawing.arrow.size.width / 2, y: bubbleFrame.minY + bubbleFrame.height))
            addArrowTipArc(with: startingPoint, to: path)
        case .left:
            let startingPoint = CGPoint(x: preferences.drawing.arrow.tip.x + preferences.drawing.arrow.size.height, y: preferences.drawing.arrow.tip.y + preferences.drawing.arrow.size.width / 2)
            path.move(to: startingPoint)
            addLeftArc(to: path)
            addBottomArc(to: path)
            addRightArc(to: path)
            addTopArc(to: path)
            path.addLine(to: CGPoint(x: preferences.drawing.arrow.tip.x + preferences.drawing.arrow.size.height, y: preferences.drawing.arrow.tip.y - preferences.drawing.arrow.size.width / 2))
            addArrowTipArc(with: startingPoint, to: path)
        }
        
        path.closeSubpath()
        
        context.addPath(path)
        context.clip()
        context.fillPath()
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: frame.height), options: [])
        context.restoreGState()
        
        if let borderColor = preferences.drawing.bubble.border.color {
            drawBubbleBorder(context, path: path, borderColor: borderColor)
        }
    }
    
    private func addTopArc(to path: CGMutablePath) {
        path.addArc(tangent1End: CGPoint(x: bubbleFrame.minX, y:  bubbleFrame.minY), tangent2End: CGPoint(x: bubbleFrame.minX, y: bubbleFrame.minY + bubbleFrame.height), radius: preferences.drawing.bubble.cornerRadius)
    }
    
    private func addRightArc(to path: CGMutablePath) {
        path.addArc(tangent1End: CGPoint(x: bubbleFrame.minX + bubbleFrame.width, y: bubbleFrame.minY), tangent2End: CGPoint(x: bubbleFrame.minX, y: bubbleFrame.minY), radius: preferences.drawing.bubble.cornerRadius)
    }
    
    private func addBottomArc(to path: CGMutablePath) {
        path.addArc(tangent1End: CGPoint(x: bubbleFrame.minX + bubbleFrame.width, y: bubbleFrame.minY + bubbleFrame.height), tangent2End: CGPoint(x: bubbleFrame.minX + bubbleFrame.width, y: bubbleFrame.minY), radius: preferences.drawing.bubble.cornerRadius)
    }
    
    private func addLeftArc(to path: CGMutablePath) {
        path.addArc(tangent1End: CGPoint(x: bubbleFrame.minX, y: bubbleFrame.minY + bubbleFrame.height), tangent2End: CGPoint(x: bubbleFrame.minX + bubbleFrame.width, y: bubbleFrame.minY + bubbleFrame.height), radius: preferences.drawing.bubble.cornerRadius)
    }
    
    private func addArrowTipArc(with startingPoint: CGPoint, to path: CGMutablePath) {
        path.addArc(tangent1End: preferences.drawing.arrow.tip, tangent2End: startingPoint, radius: preferences.drawing.arrow.tipCornerRadius)
    }
    
    private func drawTexts(to context: CGContext) {
        context.saveGState()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let xOrigin = bubbleFrame.minX + preferences.drawing.bubble.inset
        var yOrigin = bubbleFrame.minY + preferences.drawing.bubble.inset
        
        if title != nil {
            let titleRect = CGRect(x: xOrigin, y: yOrigin, width: titleSize.width, height: titleSize.height)
            title!.draw(in: titleRect, withAttributes: [NSAttributedString.Key.font : preferences.drawing.title.font, NSAttributedString.Key.foregroundColor : preferences.drawing.title.color, NSAttributedString.Key.paragraphStyle : paragraphStyle])
            
            yOrigin = titleRect.minY + titleRect.height + preferences.drawing.bubble.spacing
        }
        
        let messageRect = CGRect(x: xOrigin, y: yOrigin, width: messageSize.width, height: messageSize.height)
        message.draw(in: messageRect, withAttributes: [NSAttributedString.Key.font : preferences.drawing.message.font, NSAttributedString.Key.foregroundColor : preferences.drawing.message.color, NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
        if button != nil {
            yOrigin += messageRect.height + preferences.drawing.bubble.spacing
            
            let buttonRect = CGRect(x: xOrigin, y: yOrigin, width: buttonSize.width, height: buttonSize.height)
            button!.draw(in: buttonRect, withAttributes: [NSAttributedString.Key.font : preferences.drawing.button.font, NSAttributedString.Key.foregroundColor : preferences.drawing.button.color, NSAttributedString.Key.paragraphStyle : paragraphStyle])
        }
        
    }

}
