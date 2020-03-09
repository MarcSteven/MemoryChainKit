//
//  NSDate+CalendarView.swift
//  MCCalendarView
//
//  Created by Marc Steven on 2019/6/16.
//  Copyright © 2019 Marc Steven. All rights reserved.
//



import Foundation


public extension NSDate {
    func mcCalendarView_dayWithCalendar(calendar:NSCalendar)->NSDateComponents {
        return calendar.components([.year,.month,.day,.weekday,.calendar], from: self as Date) as NSDateComponents
    }
    func mcCalendarView_mothWithCalendar(calendar:NSCalendar) ->NSDateComponents {
        return calendar.components([.calendar, .year, .month], from: self as Date) as NSDateComponents
        
    }
    func mcCalendarView_dayIsInPast() ->Bool {
        return self.timeIntervalSinceNow <= TimeInterval(-86400)
        
    }
}
