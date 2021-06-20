//
//  BarChart.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//
import Highcharts

class BarChartView: ChartView {

    var hiStates: HIStates!
    var hiInactive: HIInactive!
    
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
        self.hiStates = HIStates()
        self.hiInactive = HIInactive()
        
        self.hiInactive.opacity = 1
        self.hiStates.inactive = self.hiInactive
        
        self.basicUISetup()
    }
    
    // MARK: Setting some default User interface
    override func basicUISetup() {
        super.basicUISetup()
        hiChart.type = ChartType.column.rawValue
    }
    
    @discardableResult
    func configureBarChartView(with dataSource: [BarChartData]) -> HIOptions {
        seriesArray.removeAll() // reseting everytime to redraw graph from begining
        for data in dataSource {
            let column = HIColumn()
            column.name = data.name
            column.data = data.data
            column.color = data.color
            column.pointWidth = data.pointWidth
            column.dataLabels = data.dataLabel
            column.states = self.hiStates
            seriesArray.append(column)
        }
        self.hiOption.series = seriesArray
        
        return hiOption
    }
    func setupStackLabel(backgroundColor: String) {
        self.hiYAxis.labels = HILabels()
        self.hiYAxis.labels.enabled = false
        self.hiYAxis.title = HITitle()
        self.hiYAxis.title.text = ""
        self.hiYAxis.stackLabels = HIStackLabels()
        self.hiYAxis.stackLabels.enabled = true
        self.hiYAxis.stackLabels.allowOverlap = false
        self.hiOption.yAxis = [self.hiYAxis]
    }
    
    func setUpXAxisCategory(with data: [String], backgroundColor: String) {
        let hiCssObject = HICSSObject()
        hiCssObject.color = "#666666"
        hiCssObject.fontSize = "12px"
        hiCssObject.fontFamily = "proximanova-semibold.otf"
        self.hiXAxis.labels = HILabels()
        self.hiXAxis.labels.style = hiCssObject
        
        self.hiXAxis.visible = true
        self.hiXAxis.lineColor = HIColor(hexValue: backgroundColor)
        self.hiXAxis.categories = data
        self.hiOption.xAxis = [self.hiXAxis]
    }
}

class BarChartData {
    var data: [Int]
    var color: HIColor!
    var pointWidth: NSNumber
    var name: String
    var dataLabel: [HIDataLabels]
    
    enum GradientOrientation {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
        
        fileprivate func getDescription() -> [AnyHashable: Any] {
            switch self {
            case .topToBottom:
                return ["x1" : 0, "x2" : 0, "y1" : 1, "y2" : 0]
            case .bottomToTop:
                return ["x1" : 0, "x2" : 0, "y1" : 0, "y2" : 1]
            case .leftToRight:
                return ["x1" : 1, "x2" : 0, "y1" : 0, "y2" : 0]
            case .rightToLeft:
                return ["x1" : 0, "x2" : 1, "y1" : 0, "y2" : 0]
            }
        }
    }
    
    struct ColorPosition {
        let colorHexCode : String
        let position : Int
        
        fileprivate func getDescription() -> [Any] {
            return [position, colorHexCode]
        }
    }
    
    init(name: String, data: [Double], color: [ColorPosition], dataLabel: [HIDataLabels], gradientOrientation: GradientOrientation = .bottomToTop, pointWidth: NSNumber = NSNumber(integerLiteral: 28)) {
        self.name = name
        self.data = data.map({ Int($0.rounded()) })
        self.color = HIColor(linearGradient: gradientOrientation.getDescription(), stops: color.compactMap({$0.getDescription()}))
        self.dataLabel = dataLabel
        switch data.count {
        case 0: self.pointWidth =  NSNumber(integerLiteral: 0)
        case 1,2: self.pointWidth =  NSNumber(integerLiteral: 35)
        case 3,4: self.pointWidth =  NSNumber(integerLiteral: 25)
        default : self.pointWidth =  NSNumber(integerLiteral: 20)
        }
    }
}
