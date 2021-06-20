//
//  City.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//
// MARK: This DTO is used for server communications 
import Foundation
struct CityDTO : Codable{
    var city : String
    var aqi : Double
 }
