//
//  Date+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension Date {
    
    // MARK: 年
    public func syab_year() -> Int {
        let calendar = Calendar.current
        let date = calendar.dateComponents([.year, .month, .day], from: self)
        return date.year!
    }
    
    // MARK: 月
    public func syab_month() -> Int {
        let calendar = Calendar.current
        let date = calendar.dateComponents([.year, .month, .day], from: self)
        return date.month!
    }
    
    // MARK: 日
    public func syab_day() -> Int {
        let calendar = Calendar.current
        let date = calendar.dateComponents([.year, .month, .day], from: self)
        return date.day!
    }
    
    // MARK: 星期几
    public func syab_weekDay() -> Int {
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    
    // MARK: 当月共有几天
    public func syab_countOfDaysInMonth() -> Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        guard range != nil else {
            return 0
        }
        return (range!.length)
    }
    
    // MARK: 当月第一天是星期几
    public func syab_firstWeekDay() -> Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
    }
    
    // MARK: 是否是今天
    public func syab_isToday() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    
    // MARK: 是否是这个月
    public func syab_isThisMonth() -> Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    // MARK: 比较时间先后 1. 前面的先； 2. 后面的先  0.相同
    static public func syab_compare(date: Date, anotherDate: Date) -> Int {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr:String = dateFormatter.string(from: date)
        let anotherDayStr:String = dateFormatter.string(from: anotherDate)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result:ComparisonResult = (dateA?.compare(dateB!))!
        //Date1 is in the future
        if(result == ComparisonResult.orderedDescending ) {
            return 1
        }
            //Date1 is in the past
        else if(result == ComparisonResult.orderedAscending) {
            return 2
        }
            //Both dates are the same
        else {
            return 0
        }
    }
    
    //  MARK: date转日期字符串
    // dateFormat: yyyy-MM-dd HH:mm:ss / yyyy-MM-dd / MM-dd HH:mm ...
    static public func syab_date(to date: Date, dateFormat: String = "yyyy-MM-dd") -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
    //  MARK: 日期字符串转date
    // dateFormat: yyyy-MM-dd HH:mm:ss / yyyy-MM-dd / MM-dd HH:mm ...
    static public func syab_date(to date: String, dateFormat: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: date)
        guard date != nil else {
            return nil
        }
        return date!
    }
    
    //  MARK: 时间比较
    static public func syab_dateDifference(date: Date, anotherDate: Date) -> Double {
        let interval = date.timeIntervalSince(anotherDate)
        return interval/86400
    }
    
    //  MARK: 时间转化成时间戳
    static public func syab_dateToTimeStamp(time: String, dateFormat: String = "yyyy-MM-dd") -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        dfmatter.locale = Locale.current
        let date = dfmatter.date(from: time)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return dateSt
    }
    
    //  MARK: 时间戳转化成时间
    static public func syab_date(from timeStamp: String, dateFormat: String = "yyyy-MM-dd") -> String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    //  MARK: 获取当前时间戳
    static public func syab_timeStamp() -> Int {
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    
    static public func syab_date(date: String) -> String {
        let timeDate = self.syab_date(to: date)
        var result: String = ""
        guard timeDate != nil else {
            return result
        }
        let currentDate = NSDate()
        let timeInterval = currentDate.timeIntervalSince(timeDate!)
        var temp: Double = 0
        
        if timeInterval/60 < 1 {
            result = "刚刚"
        } else if (timeInterval/60) < 60 {
            temp = timeInterval/60
            result = "\(Int(temp))分钟前"
        } else if timeInterval/60/60 < 24 {
            temp = timeInterval/60/60
            result = "\(Int(temp))小时前"
        } else if timeInterval/(24 * 60 * 60) < 30 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        } else if timeInterval/(30 * 24 * 60 * 60) < 12 {
            temp = timeInterval/(30 * 24 * 60 * 60)
            result = "\(Int(temp))个月前"
        } else {
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
}
    
