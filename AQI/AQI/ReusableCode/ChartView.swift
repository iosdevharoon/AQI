//
//  ChartView.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Highcharts

enum ChartType: String {
    case areaspline, area, column, bar, pie, line
}

class ChartView: HIChartView {
    
    var hiChart: HIChart!
    var hiOption: HIOptions!
    var hiSeries: HIAreaspline!
    var hiMarker: HIMarker!
    var hiAnnotation: HITooltip!
    var hiLegend: HILegend!
    var hiTitle: HITitle!
    var hiYAxis: HIYAxis!
    var hiXAxis: HIXAxis!
    var hiCssObject: HICSSObject!
    
    var numberOfGraphs = 0
    var enableMouseTracking = true
    var connectNulls = true
    
    var seriesArray = Array<HISeries>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    func setup() {
        self.hiChart = HIChart()
        self.hiOption = HIOptions()
        self.hiSeries = HIAreaspline()
        self.hiMarker = HIMarker()
        self.hiAnnotation = HITooltip()
        self.hiLegend = HILegend()
        self.hiTitle = HITitle()
        self.hiXAxis = HIXAxis()
        self.hiYAxis = HIYAxis()
        self.hiCssObject = HICSSObject()
        
        self.hiOption.title = self.hiTitle
        self.hiOption.chart = self.hiChart
        self.hiOption.legend = self.hiLegend
        self.hiOption.tooltip = self.hiAnnotation
        self.hiOption.yAxis = [self.hiYAxis]
        self.hiOption.xAxis = [self.hiXAxis]
        
        basicUISetup()
    }
    
    // MARK: Setting some default User interface
    func basicUISetup() {
        hiChart.type = ChartType.areaspline.rawValue
        hiChart.backgroundColor = HIColor.init(uiColor: UIColor.clear)
        
        setChartTitle()
        
        HICSSObject().fontFamily = "proximanova-reg-webfont"
        
        self.options = self.hiOption // setting options of chartview
        
        disableNavigationOption()
        disableCredits()
        
        showLegend(with: true) 
        
        hiCssObject.fontSize = "12px"
        hiCssObject.fontWeight = "400"
        hiCssObject.fontFamily = "proximanova-regular.otf"
        
        hiAnnotation.followPointer =  NSNumber(value: true)
        hiAnnotation.followTouchMove = NSNumber(value: true)
        hiAnnotation.valueDecimals = NSNumber(value: 0)
        
        hiXAxis.visible = NSNumber(value: false)
        hiYAxis.visible = NSNumber(value: false)
        
        self.hiMarker.enabled = NSNumber(value: false)
        
    }
    
    func setChartBgColor(from uicolor: UIColor) { hiChart.backgroundColor = HIColor.init(uiColor: uicolor) }
    
    func setChartType(type: ChartType) { hiChart.type = type.rawValue }
    
    func setChartTitle(title: String? = "") { self.hiTitle.text = title }
    
    func showLegend(with bool: Bool) {
        self.hiLegend.enabled = NSNumber(value: bool)
        self.hiOption.legend = self.hiLegend
    }
    
    func alignLegend(with layout: String) {
        self.hiLegend.layout = layout
        self.hiOption.legend = self.hiLegend
    }
    
    func setLegendsStyle() {
        self.hiLegend.enabled = true
        self.hiLegend.symbolRadius = 2
        self.hiLegend.symbolHeight = 10
        self.hiLegend.symbolWidth = 10

        self.hiCssObject.color = "#666666"
        self.hiLegend.itemStyle = self.hiCssObject
        self.hiOption.legend = self.hiLegend
    }
    
    func disableMouseTracking(for series: HISeries)   { series.enableMouseTracking = false }
    
    func disableNavigationOption() {
        let hiNavigation = HINavigation()
        let buttonOptions = HIButtonOptions()
        buttonOptions.enabled = NSNumber(value: false)
        hiNavigation.buttonOptions = buttonOptions
        
        self.hiOption.navigation = hiNavigation
    }
    
    func disableCredits() {
        let hiCredit = HICredits()
        hiCredit.enabled = NSNumber(value: false)
        
        self.hiOption.credits = hiCredit
    }
    
    func resetChartData() {
        seriesArray.removeAll()
        hiOption.series = seriesArray
    }
    
    @discardableResult func configureChartView(with dataSource: [[Any]]) -> HIOptions {
        seriesArray.removeAll() // reseting everytime to redraw graph from begining
        for data in dataSource {
            let areaSpline = HIAreaspline()
            areaSpline.data = data
            seriesArray.append(areaSpline)
            basicSeriesSetup(for: areaSpline)
        }
        self.hiOption.series = seriesArray
        
        return hiOption
    }
    
    func getOptionsWithSeries(from data: [[Any]]) -> HIOptions {
        let hiOption = HIOptions()
        var arrayOfSeries = Array<HISeries>()
        for dataObj in data {
            
            let areaSpline = HIAreaspline()
            areaSpline.data = dataObj
            arrayOfSeries.append(areaSpline)
            basicSeriesSetup(for: areaSpline)
        }
        hiOption.series = arrayOfSeries
        
        return hiOption
    }
    
    func setGradientColor(_ series: HISeries?, toGraph linearGradient: [AnyHashable: Any]? = [ "x1": 0, "x2": 0,
                                                                                               "y1": 0, "y2": 1
    ], _ stops: [[Any]]) {
        
        if series != nil { series!.color = HIColor(linearGradient: linearGradient, stops: stops) }
    }
    
    func fiilColor(_ series: HISeries?, toGraph color: UIColor) {
        if let areaSpline = series as? HIAreaspline {
            areaSpline.fillColor = HIColor.init(uiColor: color)
        }
    }
    
    func lineColor(_ series: HISeries?, ofGraph color: UIColor) {
        if let areaSpline = series as? HIAreaspline {
            areaSpline.lineColor = HIColor.init(uiColor: color)
        }
    }
    
    func enableMarker(for series: HISeries) {
        if let marker = series.marker {
            marker.enabled = NSNumber(value: true)
            series.marker = marker
        }
    }
    
    func setSeriesName(for series: HISeries, _ string: String) { series.name = string }
    
    func setSeriesColor(for series: HISeries,_ color: UIColor) {
        series.color = HIColor.init(uiColor: color)
    }
    
    func basicSeriesSetup(for series: HISeries) {
        series.showCheckbox = NSNumber(value: false)
        series.connectNulls = NSNumber(value: self.connectNulls)
        series.enableMouseTracking = NSNumber(value: self.enableMouseTracking)
        series.selected = NSNumber(value: false)
        series.marker = self.hiMarker
        hiAnnotation.pointFormatter = getPointFormatter()
    }
}

// MARK: Configuration of ToolTip
extension ChartView {
    
    var isAnnotationEnable: NSNumber {
        get { return hiAnnotation.enabled ?? NSNumber(value: true) }
        set(isEnable) { hiAnnotation.enabled = isEnable }
    }
    
    func enableSharedToolTip(_ bool: Bool) {
        self.hiAnnotation.shared = NSNumber(value: bool)
    }
    
    func setBorderWidth(_ width: Int) {
        self.hiAnnotation.borderWidth = NSNumber(value: width)
    }
    
    func enableFollowTouchMove(_ bool: Bool) {
        self.hiAnnotation.followTouchMove = NSNumber(value: bool)
    }
    
    func setHeader(_ string: String) {
        self.hiAnnotation.headerFormat = string
    }
    
    func setValuePrefix(_ string: String) {
        self.hiAnnotation.valuePrefix = string
    }
    
    func setAnnotationFormatter() {
        hiAnnotation.pointFormatter = getPointFormatter()
    }
    
    func getPointFormatter() -> HIFunction {
        let hiFunction = HIFunction()
        hiFunction.jsFunction = "function() { if (this.series.name == 'Portfolio Value') return '●'.fontcolor('#255f83') + ' ' + this.series.name + ': ' + '<b>' + '₹' + this.y.toLocaleString('en-IN') + '</b>' + '<br>'; else return '⬩'.fontcolor('yellow') + ' ' + this.series.name + ': ' + '<b>' + '₹' + this.y.toLocaleString('en-IN') + '</b>' + '<br>'; }"
        
        return hiFunction
    }
}

// MARK: X Axis and Y Axis user Interface and Data Source
extension ChartView {
    func setXAxis(with dates: [String]?) {
        if dates != nil { hiXAxis.categories = dates! }
    }
    
    func setYAxis(_ minValue: Double?, _ maxValue: Double?) {
        if minValue != nil { hiYAxis.min = NSNumber(value: minValue!) }
        if maxValue != nil { hiYAxis.max = NSNumber(value: maxValue!) }
    }
}
