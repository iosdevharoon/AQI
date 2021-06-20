//
//  LineChart.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Highcharts

class LineChartView: ChartView {
    
    var hiPlotOption: HIPlotOptions!
    var series: HISeries!
    var lines : HILine!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    override func setup() {
        super.setup()
        self.hiPlotOption = HIPlotOptions()
        self.series = HISeries()
        self.lines = HILine()
        self.hiOption.plotOptions = self.hiPlotOption
        self.hiOption.plotOptions.series = self.series
    }
    
    // MARK: Setting some default User interface
    override func basicUISetup() {
        super.basicUISetup()
        hiChart.type = ChartType.line.rawValue
    }
    
    @discardableResult
    func configureLineChartView(with dataSource: [LineChartData]) -> HIOptions {
        seriesArray.removeAll() // reseting everytime to redraw graph from begining
        for data in dataSource {
            let lineData = HILine()
            lineData.data = data.data
            lineData.color = data.color
            lineData.name = data.name
            lineData.marker = self.hiMarker
            seriesArray.append(lineData)
        }
        self.hiOption.series = seriesArray
        return hiOption
    }
    
    func setPlotOption(format: String) {
        let hiDataLabels = HIDataLabels()
        hiDataLabels.enabled = true
        hiDataLabels.align = "right"
        
        self.hiPlotOption.series.label = HILabel()
        self.hiPlotOption.series.label.connectorAllowed = false
        self.hiPlotOption.line = HILine()
        self.hiPlotOption.line.dataLabels = [hiDataLabels]
        self.hiPlotOption.line.enableMouseTracking = false
        
        self.hiOption.plotOptions = self.hiPlotOption
    }
    
    func setUpXAxisCategory(with data: [String], _ lineColor: String) {
        self.hiXAxis.categories = data
        self.hiXAxis.labels = HILabels()
        self.hiCssObject.color = "#9a9a9a"
        self.hiCssObject.fontSize = "10px"
        self.hiXAxis.labels.style = self.hiCssObject
        self.hiXAxis.lineColor = HIColor(hexValue: lineColor)
        self.hiOption.xAxis = [self.hiXAxis]
    }
    
    func setUpYAxis(_ title: String, _ lineColor: String, _ axis : [YAxis] ) {
        self.hiYAxis.title = HITitle()
        self.hiYAxis.title.text = title
        self.hiYAxis.labels = HILabels()
        self.hiYAxis.labels.enabled = false
        self.hiCssObject.color = "#9a9a9a"
        self.hiCssObject.fontSize = "12px"
        self.hiYAxis.title.style = self.hiCssObject
        self.hiYAxis.gridLineWidth = 0
        self.hiYAxis.lineWidth = 1
        self.hiYAxis.lineColor = HIColor(hexValue: lineColor)
        self.hiOption.yAxis = [self.hiYAxis]
    }
}
struct YAxis {
    var lineColor : String
    var name : String
}
class LineChartData {
    var data: [Int] = []
    var color: HIColor!
    var name: String = ""
}
