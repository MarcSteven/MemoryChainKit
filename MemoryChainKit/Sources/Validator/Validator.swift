//
//  Validator.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/7.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


open class Validator: NSObject {
    class func isValidEmailAddress(_ emailString: String?) -> Bool {
        guard emailString != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: emailString)

    }
    
    class func isValidMobile() ->Bool {
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        
        let CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        
        let CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
        
        let CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self)  == true)
            || (regextestcu.evaluate(with: self)  == true)) {
            return true
        } else {
            return false
        }
    }
    
    class func isValidPassword(_ passwordString:String?) ->Bool {
        guard passwordString != nil else {
            return false
        }
        //At least one uppercase,
        //At least one digit
        //At least one lowercase
        //8 character total
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return predicate.evaluate(with: passwordString)

        
    }
    
    
    
}
