//
//  UIScreen+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
//MARK: - properties
extension UIScreen {
    public class var screenWidth:CGFloat {
        return UIScreen.main.bounds.size.width
    }
    public class var screenHeight:CGFloat {
        return UIScreen.main.bounds.size.height
    }
    public static func screen_width() ->CGFloat {
        return main.bounds.size.width
    }
    public static func screen_height() ->CGFloat {
        return main.bounds.size.height
    }
}
