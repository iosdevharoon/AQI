//
//  HistoricalDataMV.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
import UIKit

class HistoricalDataVM {
    // MARK: Instance variables
    weak var delegate : HistoricalDataVMDelegate!
    var cityList = [City]()
    
    init(delegate : HistoricalDataVMDelegate) {
        self.delegate = delegate
    }
    
    func getValuesFromDabase() {
        //Giving a call to caller to start loading
        self.delegate.startLoading()
        HistoricalDataManager.shared.fetchAllCities { values in
            //Data received from database notifing the caller
            self.cityList = values
            self.delegate.receviedDataSuccessfully()
        }
        
    }
    //Providing the data to show on chart.
    func getLineDataForAllCities() -> [LineChartSeriesData]{
        
        var retVal = [LineChartSeriesData]()
        self.cityList.forEach { city in
            let linechartdata = LineChartSeriesData(name: city.name, data: city.aqi, color: UIColor.random(), timeList: city.lastModificationTime.map{$0.getTime()})
            retVal.append(linechartdata)
        }
        return retVal
    }
}

// MARK: Model for sending data between view and viewModel
struct LineChartSeriesData{
    var name : String
    var data : [Double]
    var color : UIColor
    var timeList : [String]
}

// MARK: Protocol to notify caller to show loading and show data
protocol HistoricalDataVMDelegate : AnyObject{
    func receviedDataSuccessfully()
    func startLoading()
}

