//
//  UIStoryboard.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit

extension UIStoryboard {
    fileprivate static let main = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: Configure function
    func getViewController<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: T.storyboardID) as! T
    }
    // MARK: View Controller's reference and setup config
    class func getCityListViewController() -> CityListViewController {
       return main.getViewController()
    }
    class func getHistroyViewController() -> HistoricalViewController {
       return main.getViewController()
    }
    class func getChartViewController(forCity name : String?, existingCities : [City]?) -> ChartViewController {
        let vc : ChartViewController = main.getViewController()
        vc.viewModel = ChartViewModel(isForCity: name, existingCities: existingCities, delegate: vc)
        return vc
    }
}
