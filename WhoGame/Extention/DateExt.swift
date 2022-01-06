//
//  DateExt.swift
//  CoachApp
//
//  Created by Иван Маришин on 02.11.2021.
//

import Foundation

extension Date {
    var dayNumberOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.string(from: self)
    }
    
    func getGMTTimeDate() -> Date {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        comp.calendar = Calendar.current
        comp.timeZone = TimeZone(abbreviation: "GMT")
        return Calendar.current.date(from: comp) ?? Date()
    }
    
    func getGMTStartDate() -> Date {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        comp.calendar = Calendar.current
        comp.timeZone = TimeZone(abbreviation: "GMT")
        return Calendar.current.date(from: comp) ?? Date()
    }
}
