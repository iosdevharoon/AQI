//
//  CityListingVM.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
class CityListingViewModel {
    
    
    var hasCityDataFetched = Binding<Bool?>.init(value: nil)
    private var cityList = [City]()
    
    lazy var observer = CityEventObserver(
        eventHandler: {[weak self](data, errorMessage) in
            self?.addOrUpdateCitiesInList(cities: data)
        })
    
    init() {
        NetworkManager.shared.addCityObserver(observer: observer)
    }
    private func addOrUpdateCitiesInList(cities : [CityDTO]?){
        func addOrUpdateCity(city : CityDTO){
            if let existingCity = self.cityList.first(where: { _city in return _city.name == city.city}){
                existingCity.aqi.append(city.aqi)
                existingCity.lastModificationTime.append(Date())
                HistoricalDataManager.shared.save(city: existingCity)
                
            } else {
                
                let newcity = City(city: city, lastModificationTime: Date())
                self.cityList.append(newcity)
                HistoricalDataManager.shared.save(city: newcity)
            }
        }
        if let allCities = cities, allCities.count > 0{
            allCities.forEach{addOrUpdateCity(city: $0)}
            self.hasCityDataFetched.value = true
        }
    }
    func getNumberOfCities() -> Int{
        return self.cityList.count
    }
    func getCityAtIndex(index : Int) -> City?{
        if index < self.cityList.count{
            return self.cityList[index]
        }
        return nil
    }
    func getAllCities() -> [City]{
        return self.cityList
    }
    
}
