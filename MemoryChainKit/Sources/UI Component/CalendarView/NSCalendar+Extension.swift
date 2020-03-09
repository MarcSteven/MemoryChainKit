//  NSCalendar+Extension.swift
//  MCCalendarView
//
//  Created by Marc Steven on 2019/6/16.
//  Copyright © 2019 Marc Steven. All rights reserved.
//

import Foundation


public extension NSCalendar {
    class func usLocaleCurrentCalendar() ->NSCalendar {
        let us = NSLocale(localeIdentifier: "en_US")
        var calendar = NSCalendar.current
        calendar.locale = us  as Locale
        return calendar as NSCalendar
    }
}
