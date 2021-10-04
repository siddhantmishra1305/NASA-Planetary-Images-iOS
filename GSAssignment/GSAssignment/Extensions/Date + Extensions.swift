//
//  Date + Extensions.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 03/10/21.
//

import Foundation

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var fewDaysBack:Date?{
        return Calendar.current.date(byAdding: .day, value: -10, to: Date())
    }
    
    var dayBefore:Date?{
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
}
