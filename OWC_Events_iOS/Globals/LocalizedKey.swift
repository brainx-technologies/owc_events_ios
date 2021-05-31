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

    case empty = ""
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
    case aboutThisEvent = "About this event"
    case seeMore = "See More"
    case threeDots = "... "
    case viewMap = "View Map"
    case addToCalendar = "Add To Calendar"
    case openGoogleMap = "Open Google Map"
    case openAppleMap = "Open Apple Map"
    case cancel = "Cancel"
    case cannotUseGoogleMapMessage = "Can't use google maps"
    case failedToSave = "failed to save event with error"
    case successTitle = "Event Added Successfully"
    case successMessage = "Your event added successfully to your calendar"
    case done = "Done"
    case noEventsAvailable = "No Events Available"
    case noEventFound = "No Event Found"
}
