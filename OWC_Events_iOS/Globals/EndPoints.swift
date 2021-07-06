//
//  EndPoints.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/27/21.
//

import CoreLocation
import Foundation

class EndPoints {
    static func createGoogleMapURL(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> URL? {
        return URL(string: "comgooglemaps://?center=\(latitude),\(longitude)&zoom=0.1&views=traffic&q=\(latitude),\(longitude)")
    }
}
