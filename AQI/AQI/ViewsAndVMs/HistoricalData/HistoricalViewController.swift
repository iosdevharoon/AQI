//
//  HistoricalViewController.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit
import Highcharts


class HistoricalViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!{
        didSet{
            self.loadingView.layer.cornerRadius = 16.0
            self.loadingView.layer.borderWidth = 2.0
            self.loadingView.layer.borderColor = UIColor.lightGray.cgColor
            self.loadingView.layer.shadowColor = UIColor.lightGray.cgColor
            self.loadingView.layer.shadowOffset = CGSize.zero
            self.loadingView.layer.shadowRadius = 10.0
            self.loadingView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var viewCanvas: UIView!
    var chartView : LineChartView!
    lazy var viewModel = HistoricalDataVM(delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Historical Data"
        self.viewModel.getValuesFromDabase()
        
    }

}
extension HistoricalViewController : HistoricalDataVMDelegate{
    func receviedDataSuccessfully() {
        DispatchQueue.main.async {
            var data: [LineChartData] = [LineChartData]()
            
            let lineData = self.viewModel.getLineDataForAllCities()
            lineData.forEach { line in
                let dt = LineChartData()
                dt.color = HIColor(uiColor: line.color)
                dt.data = line.data.map{Int($0.rounded())}
                dt.name = line.name
                data.append(dt)
            }
            
            self.chartView = LineChartView(frame: self.viewCanvas.bounds)
            self.chartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.chartView.configureLineChartView(with: data)
            self.viewCanvas.addSubview(self.chartView)
            self.loadingView.isHidden = true
        }
    }
    
    func startLoading() {
        self.loadingView.isHidden = false
    }
}
