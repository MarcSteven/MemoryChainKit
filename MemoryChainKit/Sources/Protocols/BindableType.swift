//
//  BindableType.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/9/11.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol BindableType {
    associatedtype ViewModelType
    var viewModel:ViewModelType! {get set}
    func bindViewModel()
}
extension BindableType where Self:UIViewController {
    mutating func bindViewModel(to model:Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
