//
//  IntroducationImageProtocol.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
public enum IntroducationImagePosition {
    case always
    case pageIndex(Int)
    
}
// video protocol
public protocol IntroducationVideoProtocol {
    func introducationPageDidClickEnterButton(enterButton:UIButton)
    func introducationPageCustomizedViews() ->[UIView]?
    
}
extension IntroducationVideoProtocol {
    func introducationPageCustomizedViews() ->[UIView]? {return nil}
}
public protocol IntroducationImageProtocol {
    func introducationPageCustomizedPageControl(_ pageControl:PageControl)
    func introducationPageCustomizedEnterButton(_ enterButton:UIButton) ->IntroducationImagePosition
    func introducationPageCustomizedView() -> [(UIView,IntroducationImagePosition)]?
    
}
extension IntroducationImageProtocol {
    func introducationPageCustomizedPageControl(_ pageControl:PageControl) {}
    func introducationPageCustomizedView() -> [(UIView,IntroducationImagePosition)]? {return nil}
    
}

