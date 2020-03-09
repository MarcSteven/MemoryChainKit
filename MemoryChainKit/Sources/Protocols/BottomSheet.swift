//
//  BottomSheet.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
protocol BottomSheetDelegate:AnyObject {
    func bottomSheet(_ bottomSheet:BottomSheet,didScrollTo contentOffset:CGPoint)
}
protocol BottomSheet:AnyObject {
    var bottomSheetDelegate:BottomSheetDelegate? {get set}
}
typealias BottomSheetViewController = UIViewController & BottomSheet

