//
//  LocalizedKey.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation

enum LocalizedKey: String {
    var string: String {        
        NSLocalizedString(self.rawValue, comment: "")
    }
    case ok = "ok"
    case error = "Error"
    case success = "Success"
    case urlNotFound = "Url not found"
    case appName = "OWC Events"
}


