//
//  Notification+Extension.swift
//  IDOVFPDetail
//
//  Created by Marc Zhao on 2018/8/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

import Foundation

extension Notification.Name {
    //MARK: - post 
    func post(object:Any? = nil,userInfo:[AnyHashable:Any]? = nil) {
        NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
    }
    
}
