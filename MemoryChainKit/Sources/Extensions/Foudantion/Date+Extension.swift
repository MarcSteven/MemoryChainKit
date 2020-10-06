//
//  Date+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
//MARK: - method
public extension Date {
    func next() ->Date? {
        let calendar = Calendar.current
        let daysComponents = calendar.dateComponents([.month,.day], from: self)
        return calendar.nextDate(after: Date(), matching: daysComponents, matchingPolicy: .nextTime)
    }
    func at(_ hours:Int,minutes:Int = 0) ->Date {
        return  Calendar.current.date(bySettingHour: hours, minute: minutes, second: 0, of: self)!
        
    }
    static func data_form(string:String?) ->Date? {
        return self.data_form(string: string, formatter: "yyyy-MM-dd HH:mm:ss")
    }
    static func data_form(string:String?, formatter:String?)->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let date_formatter = formatter {
            dateFormatter.dateFormat = date_formatter
            if let time_string = string {
                let date = dateFormatter.date(from: time_string)
                return date
            }
        }
        return nil
    }
    func string_from(formatter:String?) -> String {
        if formatter != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = formatter
            let date_String = dateFormatter.string(from: self)
            return date_String
        }
        return ""
    }
    
    
    
    // 获得当天星期几
    func getDayAndWeek() ->String {
        var date = ""
        let weekDay = self.getAbbreviationWeekDay(weekDay: self.weekDay())
        date = String(self.day()) + weekDay
        return date
    }
    
    func getAbbreviationWeekDay(weekDay: Int) -> String {
        switch weekDay {
        case 1: return "Mon"
        case 2: return "Tue"
        case 3: return "Wed"
        case 4: return "Thu"
        case 5: return "Fri"
        case 6: return "Sat"
        case 7: return "Sun"
        default:
            return ""
        }
    }
    
    func getAbbreviationMonth(unixDate: Int64) ->String {
        if unixDate == 0 {
            return "Jan"
        }
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = Int(formatter.string(from: date))
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return "Jan"
        }
    }
}
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

extension Date {
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    //MARK: 月
    func month() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
    }
    //MARK: 日
    func day() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
    }
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    // 获取当前 秒级 时间戳 - 
    var timeStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int64(timeInterval)
        return timeStamp
    }
    
    // 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // 转日记时间格式
    var noteDate: String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日 HH:mm"
        return dateFormat.string(from: date)
    }
    
    func noteDate(unixTime: Int64) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日 HH:mm"
        return dateFormat.string(from: date)
    }
    
    func getNoteDate(unixTime: Int64) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        return dateFormat.string(from: date)
    }
}

public extension Date {
    
    static func formatTime(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let fmt = DateFormatter()
        if date.isToday() {
            fmt.dateFormat = "HH:mm"
        }else {
            if date.isYesterday() {
                fmt.dateFormat = "昨天 HH:mm"
            }else if date.isCurrentWeek() {
                fmt.dateFormat = "MM-dd HH:mm"
            }else {
                fmt.dateFormat = "yyyy-MM-dd"
            }
        }
        return fmt.string(from: date)
    }
    
    func isJust() -> Bool {
        let nowTimeStamp = Date().timeIntervalSince1970
        let selfTimeStamp = self.timeIntervalSince1970
        return nowTimeStamp - selfTimeStamp <= 60
    }
    
    func diffMins() -> String {
        let nowTimeStamp = Date().timeIntervalSince1970
        let selfTimeStamp = self.timeIntervalSince1970
        if nowTimeStamp - selfTimeStamp < 60 * 60 {
            return "\(Int(floor((nowTimeStamp - selfTimeStamp) / 60)))分钟前"
        }
        return ""
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        let nowComponents = calendar.dateComponents(unit, from: Date())
        let selfComponents = calendar.dateComponents(unit, from: self)
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day)
    }
    
    func diffHours() -> String {
        let nowTimeStamp = Date().timeIntervalSince1970
        let selfTimeStamp = self.timeIntervalSince1970
        if nowTimeStamp - selfTimeStamp < 60 * 60 * 24 {
            return "\(Int(floor((nowTimeStamp - selfTimeStamp) / 60 / 60)))小时前"
        }
        return ""
    }
    
    func isYesterday() -> Bool {
        let nowDate = Date().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day == 1
    }
    
    func dateFormatYMD() -> Date {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let selfStr = fmt.string(from: self)
        return fmt.date(from: selfStr)!
    }
    
    func isCurrentWeek() -> Bool {
        let nowDate = Date().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day! <= 7
    }
    
    func dateFormatYear() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy"
        return fmt.string(from: self)
    }
    
    func isCurrentYear() -> Bool {
        let nowDate = Date().dateFormatYear()
        let selfDate = self.dateFormatYear()
        return nowDate == selfDate
    }
    
    static func formatTimeDetailLabel(timestamp: Int64) -> String {
        if timestamp > 0 {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp/1000))
            let fmt = DateFormatter()
            if date.isToday() {
                fmt.dateFormat = "HH:mm:ss"
            }else {
                fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            }
            return fmt.string(from: date)
        }
        return ""
    }
    
    static func formatDateString(dateString: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = fmt.date(from: dateString) ?? Date()
        if date.isJust() {
            return "刚刚"
        }else if !date.diffMins().isBlank {
            return date.diffMins()
        }else if !date.diffHours().isBlank {
            return date.diffHours()
        }else if date.isYesterday() {
            fmt.dateFormat = "昨天 HH:mm"
            return fmt.string(from: date)
        }else if date.isThisYear() {
            fmt.dateFormat = "MM-dd"
            return fmt.string(from: date)
        }else {
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt.string(from: date)
        }
    }
    
    static func formatYYYYDateString(dateString: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = fmt.date(from: dateString) ?? Date()
        fmt.dateFormat = "yyyy年MM月dd日"
        return fmt.string(from: date)
    }
}


