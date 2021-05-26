//
//  LocalizedKey.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation

enum LocalizedKey: String {
    var string: String {
        NSLocalizedString(rawValue, comment: "")
    }

    case appName = "OWC Events"
    case error = "Error"
    case events = "Events"
    case ok = "OK"
    case searchEvents = "Search Events"
    case selectDate = "Select Date"
    case selectMonth = "Select Month"
    case success = "Success"
    case typeTheme = "Type/Theme"
    case urlNotFound = "Url not found"
    case filter = "Filter"
    case selectAll = "Select All"
    case applyFilter = "Apply Filter"
    case clearAll = "Clear All"
    case location = "Location"
    case eventDetails = "Event Details"
}
