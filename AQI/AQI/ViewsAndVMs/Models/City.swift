//
//  City.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
// MARK: This Model is used for View-ViewModel communications
class City {
    var name : String
    var aqi : [Double]
    var lastModificationTime : [Date]
    
    // MARK: Default initializer
    init(name : String, aqi : [Double], lastModificationTime : [Date]) {
        self.name = name
        self.aqi = aqi
        self.lastModificationTime = lastModificationTime
    }
    // MARK: Initializer used from server events
    init(city : CityDTO, lastModificationTime : Date) {
        self.name = city.city
        self.aqi = [Double]()
        self.aqi.append(city.aqi)
        self.lastModificationTime = [Date]()
        self.lastModificationTime.append(lastModificationTime)
    }
}


extension City : Equatable{
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}
