//
//  CityListingVM.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
class CityListingViewModel {
    // MARK: Instance Variables
    var hasCityDataFetched = Binding<Bool?>.init(value: nil)
    private var cityList = [City]()
    // MARK: Event Observer
    lazy var observer = CityEventObserver(
        eventHandler: {[weak self](data, errorMessage) in
            self?.addOrUpdateCitiesInList(cities: data)
        })
    // MARK: Initialization
    init() {
        NetworkManager.shared.addCityObserver(observer: observer)
    }
    // MARK: Add Cities to Data Source and use to nested func
    private func addOrUpdateCitiesInList(cities : [CityDTO]?) {
        func addOrUpdateCity(city : CityDTO){
            if let existingCity = self.cityList.first(where: { _city in return _city.name == city.city}){
                //Existing city founf with this name hence using same object for storing entries
                existingCity.aqi.append(city.aqi)
                existingCity.lastModificationTime.append(Date())
                //Saving data to historical data source for historical view and permanent storage
                HistoricalDataManager.shared.save(city: existingCity)
                
            } else {
                //No existing city with this name hence creating a new object and will store upcoming entries in this object
                let newcity = City(city: city, lastModificationTime: Date())
                self.cityList.append(newcity)
                //Saving data to historical data source for historical view and permanent storage
                HistoricalDataManager.shared.save(city: newcity)
            }
        }
        if let allCities = cities, allCities.count > 0{
            allCities.forEach{addOrUpdateCity(city: $0)}
            self.hasCityDataFetched.value = true
        }
    }
    // MARK: DataSource functions
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
