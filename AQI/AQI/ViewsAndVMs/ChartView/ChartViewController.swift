//
//  ChartViewController.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit
import Highcharts

class ChartViewController: UIViewController {
    @IBOutlet weak var viewCanvas: UIView!
    
    var viewModel : ChartViewModel!
    var chartView : BarChartView!
    var  hiDataLabels : HIDataLabels!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.getSelectedCityName() ?? "All cities"
        self.setUpChartView()
    }
    
    func setUpChartView() {
        hiDataLabels = HIDataLabels()
        hiDataLabels.enabled = true
        hiDataLabels.y = -10
        hiDataLabels.format = "{point.y}"
        self.chartView = BarChartView(frame: self.viewCanvas.bounds)
        self.chartView.setLegendsStyle()
        self.chartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.viewCanvas.addSubview(self.chartView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.viewModel.isForSingleCity(){
                self.reloaddataForSingleCity()
            } else{
                self.reloadDataForAllCities()
            }
        }
    }
    
    func reloadDataForAllCities(){
        let mapping = self.viewModel.getGraphDataForAllCitiesAndLatestAQIMaping()
        var data: [BarChartData] = [BarChartData]()
        let oneValues = mapping.1
        data.append(BarChartData(name: "Air Quality Index", data: oneValues,
                                     color: [BarChartData.ColorPosition(colorHexCode: "#5148F5", position: 0),
                                             BarChartData.ColorPosition(colorHexCode: "#6C49CF", position: 1)],
                                     dataLabel: [self.hiDataLabels]))
        
        self.chartView.configureBarChartView(with: data)
        self.chartView.setUpXAxisCategory(with: mapping.0, backgroundColor: "FFFFFF")
    }
    func reloaddataForSingleCity(){
        let mapping = self.viewModel.getAllUpdateTimeAQIMappingForSelectedCity()
        var data: [BarChartData] = [BarChartData]()
        
        data.append(BarChartData(name: "Air Quality Index", data: mapping.0,
                                     color: [BarChartData.ColorPosition(colorHexCode: "#5148F5", position: 0),
                                             BarChartData.ColorPosition(colorHexCode: "#6C49CF", position: 1)],
                                     dataLabel: [self.hiDataLabels]))
        self.chartView.configureBarChartView(with: data)
        self.chartView.setUpXAxisCategory(with: mapping.1.map{$0.getTime()}, backgroundColor: "FFFFFF")
    }
}
extension ChartViewController : ChartDelegate{
    func updateAllCitiesLastAQI() {
        self.reloadDataForAllCities()
    }
    
    func updateAQIForSingleCity() {
        self.reloaddataForSingleCity()
    }
    
    
}
