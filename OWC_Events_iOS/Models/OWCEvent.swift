//
//  OWCEvent.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import Foundation
import ObjectMapper

class OWCEvent: Mappable {
    var id: Int?
    var title: String?
    var startDate: Date?
    var endDate: Date?
    var location: String?
    var isKindOf: [String]?
    
    required init?(map _: Map) {}
    
    init(id: Int, title: String, startDate: Date, endDate: Date, location: String, kinds: [String]) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.isKindOf = kinds
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        location <- map["location"]
        isKindOf <- map["kinds"]
    }
}
