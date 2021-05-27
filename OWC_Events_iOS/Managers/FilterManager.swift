//
//  FilterManager.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/27/21.
//

import Foundation

class FilterManager {
    static func getFilterBeingApplied(withCompletion completion: @escaping ([TypesAndThemeFilters], [LocationFilters]) -> Void){
        var typeThemeFilters: [TypesAndThemeFilters] = []
        var locationFilters: [LocationFilters] = []
        let typeThemeFilterRawValues = UserDefaultsManager.typeThemeFilters
        let locationFilterRawValues = UserDefaultsManager.locationFilters
        for filterRawValue in typeThemeFilterRawValues {
            if let newFilter = TypesAndThemeFilters(rawValue: filterRawValue){
                typeThemeFilters.append(newFilter)
            }
        }
        for filterRawValue in locationFilterRawValues {
            if let newFilter = LocationFilters(rawValue: filterRawValue){
                locationFilters.append(newFilter)
            }
        }
        completion(typeThemeFilters,locationFilters)
    }
}
