
//
//  ExtDate.swift
//  MySwiftTemplate
//
//  Created by apple on 25/10/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
//一天的秒数
private let OneDaySeconds : TimeInterval = 86400

extension Date {
    //一天之前的时间
    public static func oneDayAgo() -> Date {
        return Date(timeIntervalSinceNow: -OneDaySeconds)
    }
    
    //当天的零点
    public static func zeroHourToday() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    //几天之前/之后
    public func dayBy(dayOffset: TimeInterval) -> Date {
        return self.addingTimeInterval(dayOffset * OneDaySeconds)
    }
    
    //判断是否是今天
    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public func isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    public func isTommorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    public func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public func hour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public func minutes() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public func seconds() -> Int {
        return Calendar.current.component(.second, from: self)
    }
}
