//
//  MCInformationTipPreferences.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/15.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

@objc public class MCInformationTipPreferences:NSObject {
    
    @objc public class Drawing:NSObject {
        @objc public class Arrow:NSObject {
            
            @objc public var tip:CGPoint  = .zero
            @objc public var size:CGSize = CGSize(width:20,height:10)
            @objc public var tipCornerRadius:CGFloat = 5
            
        }
        @objc public class Bubble:NSObject {
            @objc public class Border:NSObject {
                @objc public var color:UIColor? = nil
                @objc public var width:CGFloat = 1
            }
            @objc public var inset:CGFloat = 15
            @objc public var spacing:CGFloat = 5
            @objc public var cornerRadius:CGFloat = 5
            @objc public var maxWidth:CGFloat = 210
            @objc public var color:UIColor = UIColor.clear {
                didSet {
                    gradientColors = [color]
                    gradientLocations = []
                }
            }
            @objc public var gradientColors:[UIColor] = [UIColor(red: 0.761, green: 0.914, blue: 0.984, alpha: 1.0),UIColor(red: 0.631, green: 0.769, blue: 0.992, alpha: 1.00)]
            @objc public var gradientLocations:[CGFloat] = [0.05,1.0]
            @objc public var border:Border = Border()
        }
        @objc public class Title:NSObject {
            @objc public var font:UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
            @objc public var color:UIColor = .white
            
        }
        @objc public class Message:NSObject {
            @objc public var font :UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            @objc public var color:UIColor = .white
            
        }
        @objc public class Button:NSObject {
            @objc public var font:UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            @objc public var color:UIColor = .white
        }
        @objc public class Background:NSObject {
            @objc public var color:UIColor = UIColor.clear {
                didSet {
                    gradientColor = [.clear,color]
                    
                }
            }
            //MARK: - TODO
            @objc public var gradientColor:[UIColor] = [.clear,UIColor.black.withAlphaComponent(0.4)]
            @objc public var gradientLocation:[CGFloat] = [0.05,1.0]
        }
        @objc public var arrow:Arrow = Arrow()
        @objc public var bubble:Bubble = Bubble()
        @objc public var title:Title = Title()
        @objc public var message:Message = Message()
        @objc public var button:Button = Button()
        @objc public var background:Background = Background()
    }
    @objc public class  MCAnimating:NSObject {
        @objc public var dismissTransfor:CGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        @objc public var displayInitialTransform:CGAffineTransform = CGAffineTransform(scaleX: 0, y: 0)
        @objc public var displayFinalTransform:CGAffineTransform = .identity
        @objc public var springDamping:CGFloat = 0.7
        @objc public var springVelocity:CGFloat = 0.7
        @objc public var displayInitialAlpha:CGFloat = 0
        @objc public var hideFinalAlpha:CGFloat = 0
        @objc public var durationOfDisplaying:TimeInterval = 0.7
        @objc public var durationOfDismissing:TimeInterval = 0.7
        
    }
    @objc public var drawing:Drawing = Drawing()
    @objc public var animating:MCAnimating = MCAnimating()
    
    @objc public override init() {
        
    }

}
