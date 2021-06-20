//
//  HistoricalDataMV.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
import UIKit

struct LineChartSeriesData{
    var name : String
    var data : [Double]
    var color : UIColor
    var timeList : [String]
}

protocol HistoricalDataVMDelegate : AnyObject{
    func receviedDataSuccessfully()
    func startLoading()
}

class HistoricalDataVM {
    weak var delegate : HistoricalDataVMDelegate!
    var cityList = [City]()
    
    init(delegate : HistoricalDataVMDelegate) {
        self.delegate = delegate
    }
    func getValuesFromDabase(){
        self.delegate.startLoading()
        HistoricalDataManager.shared.fetchAllCities { values in
            self.cityList = values
            self.delegate.receviedDataSuccessfully()
        }
        
    }
    func getLineDataForAllCities() -> [LineChartSeriesData]{
        
        var retVal = [LineChartSeriesData]()
        self.cityList.forEach { city in
            let linechartdata = LineChartSeriesData(name: city.name, data: city.aqi, color: UIColor.random(), timeList: city.lastModificationTime.map{$0.getTime()})
            retVal.append(linechartdata)
        }
        return retVal
    }
    

}
