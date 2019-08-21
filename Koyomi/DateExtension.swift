//
//  DateExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/14.
//
//

import UIKit

extension Date {
    func formated(withFormat format: String = "yyyy/MM/dd") -> Date? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "Europe/London")
        let dateString = formatter.string(from: self)
        return formatter.date(from: dateString)
    }
    
    func daysSince(_ anotherDate: Date) -> Int? {
        if let fromDate = dateFromComponents(self), let toDate = dateFromComponents(anotherDate) {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "Europe/London")!
            let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
            return components.day
        }
        return nil
    }
    
    private func dateFromComponents(_ date: Date) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Europe/London")!
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)
    }
}
