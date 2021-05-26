//
//  Date.swift
//  Tespo Health
//
//  Created by BrainX Technologies on 09/05/2020.
//  Copyright © 2020 BrainX Technologies. All rights reserved.
//

import Foundation

extension Date {
    static var monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    func firstDayOfWeek() -> Date {
        let c = Calendar(identifier: .iso8601)
        let date = c.date(from: c.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)) ?? Date()
        return date
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func isSameDay(date: Date?) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date ?? Date())
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
}
