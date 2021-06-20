//
//  CityListingVM.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//
import Foundation
protocol ChartDelegate : AnyObject {
    func updateAllCitiesLastAQI()
    func updateAQIForSingleCity()
}
class ChartViewModel {
    weak var delegte : ChartDelegate!
    
    private var cityList = [City]()
    private var cityName : String?
    
    lazy var observer = CityEventObserver(
        eventHandler: {[weak self](data, errorMessage) in
            self?.addOrUpdateCitiesInList(cities: data)
        })
    
    
    init(isForCity name : String?, existingCities : [City]?, delegate : ChartDelegate) {
        self.delegte = delegate
        self.cityName = name
        self.cityList = existingCities ?? [City]()
        NetworkManager.shared.addCityObserver(observer: observer)
    }
    
    func isForSingleCity() -> Bool { return cityName != nil }
    
    private func addOrUpdateCitiesInList(cities : [CityDTO]?) {
        func addOrUpdateCity(city : CityDTO) {
            if let existingCity = self.cityList.first(where: { _city in return _city.name == city.city}) {
                existingCity.aqi.append(city.aqi)
                existingCity.lastModificationTime.append(Date())
            } else {
                let newcity = City(city: city, lastModificationTime: Date())
                self.cityList.append(newcity)
            }
            if isForSingleCity() {
                self.delegte.updateAQIForSingleCity()
            }
            
        }
        if let allCities = cities, allCities.count > 0 {
            allCities.forEach{ addOrUpdateCity(city: $0) }
            if !isForSingleCity() {
                self.delegte.updateAllCitiesLastAQI()
            }
        }
    }
    
    func getAllUpdateTimeAQIMappingForSelectedCity() -> ([Double],[Date]) {
        
        var retVal = ([Double](), [Date]())
        
        if let existingCity = self.cityList.first(where: { _city in return _city.name == self.cityName ?? ""}) {
            if var previousUpdateTime = existingCity.lastModificationTime.first{
                
                retVal.0.append(existingCity.aqi[0])
                retVal.1.append(existingCity.lastModificationTime[0])
                
                for i in 0..<existingCity.lastModificationTime.count{
                    let interval = Date.getTimeDifferenceinSeconds(from: previousUpdateTime, toDate: existingCity.lastModificationTime[i])
                    if interval > 30{
                        retVal.0.append(existingCity.aqi[i])
                        retVal.1.append(existingCity.lastModificationTime[i])
                        previousUpdateTime = existingCity.lastModificationTime[i]
                    }
                }
            }
        }
        return retVal
    }
    
    func getGraphDataForAllCitiesAndLatestAQIMaping() -> ([String], [Double]) {
        
        var retVal = ([String](), [Double]())
        
        for city in self.cityList{
            if let lastAQIValue = city.aqi.last{
                retVal.0.append(city.name)
                retVal.1.append(lastAQIValue)
            }
        }
        
        return retVal
    }
    
    func getDataForSelectedCity() -> City?{
        
        if isForSingleCity(){
            if let existingCity = self.cityList.first(where: { _city in return _city.name == self.cityName!}) {
                return existingCity
            }
        }
        
        return nil
    }
    
    func getSelectedCityName() -> String?{ return cityName }
}
