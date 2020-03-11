//
//  UITableView+ConfigureProtocols.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/25.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension UITableView {
    func ConfigureProtocols() {
        self.delegate = self as? UITableViewDelegate
        self.dataSource = (self as? UITableViewDataSource)
    }
    func configureHeaderView() {
        self.tableHeaderView = UIView(frame: .zero)
    }
    func configureFooterView() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
