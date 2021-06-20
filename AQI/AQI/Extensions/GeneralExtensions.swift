//
//  GeneralExtensions.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
import UIKit

extension Double{
    func getDesriptionOfAQI() -> String{
        if self < 51{
            return "Good"
        } else if self >= 51 && self < 101{
            return "Satisfactory"
        } else if self >= 101 && self < 201{
            return "Moderate"
        } else if self >= 201 && self < 301{
            return "Poor"
        } else if self >= 301 && self < 401{
            return "Very Poor"
        } else{
            return "Severe"
        }
    }
    func getColourForAQI() -> UIColor{
        if self < 51{
            return UIColor(red: 70.0/255.0, green: 155.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        } else if self >= 51 && self < 101{
            return UIColor(red: 146.0/255.0, green: 192.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        } else if self >= 101 && self < 201{
            return UIColor(red: 255.0/255.0, green: 250.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        } else if self >= 201 && self < 301{
            return UIColor(red: 238.0/255.0, green: 138.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        } else if self >= 301 && self < 401{
            return UIColor(red: 225.0/255.0, green: 39.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        } else{
            return UIColor(red: 156.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
    }
    func getTextColourForAQI() -> UIColor{
        if self < 51{
            return UIColor(red: 70.0/255.0, green: 155.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        } else if self >= 51 && self < 101{
            return UIColor(red: 146.0/255.0, green: 192.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        } else if self >= 101 && self < 201{
            return UIColor(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        } else if self >= 201 && self < 301{
            return UIColor(red: 238.0/255.0, green: 138.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        } else if self >= 301 && self < 401{
            return UIColor(red: 225.0/255.0, green: 39.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        } else{
            return UIColor(red: 156.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
    }
    func getImageForAQI() -> UIImage{
        if self < 51{
            return UIImage(named: "good")!
        } else if self >= 51 && self < 101{
            return UIImage(named: "satisfactory")!
        } else if self >= 101 && self < 201{
            return UIImage(named: "moderate")!
        } else if self >= 201 && self < 301{
            return UIImage(named: "poor")!
        } else if self >= 301 && self < 401{
            return UIImage(named: "verypoor")!
        } else{
            return UIImage(named: "severe")!
        }
    }
}
extension Date {
    static func getTimeDifferenceinSeconds(from : Date, toDate : Date) -> Int{
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: from, to: toDate)
        let seconds = dateComponents.second
        return Int(seconds!)
    }
    func getTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss a"
        return formatter.string(from: self)
    }
    func getTimeDestription() -> String{
        
        let secondInt = Date.getTimeDifferenceinSeconds(from: self, toDate: Date())
        if secondInt < 60 {
            return "A few seconds ago"
        } else if secondInt >= 60 && secondInt < 120{
            return "A minute ago"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm a"
            return formatter.string(from: self)
        }
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
