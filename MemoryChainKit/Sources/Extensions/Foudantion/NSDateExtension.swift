//
//  NSDateExtension.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/11/29.
//  Copyright © 2021 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
//MARK: - method for date

public extension NSDate {
    class func date_form(string:String?) ->NSDate? {
        return self.date_from(string: string, formatter: "yyyy-MM-DD HH:mm:ss")
      
    }
    class func date_from(string: String?, formatter: String?) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let da_formatter = formatter {
            dateFormatter.dateFormat = da_formatter
            if let time_str = string  {
                let date = dateFormatter.date(from: time_str)
                return date as NSDate?
            }
        }
        return nil
    }
}
