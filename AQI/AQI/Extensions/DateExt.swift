//
//  DateExt.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//
import Foundation

extension Date {
    static func getTimeDifferenceinSeconds(from : Date, toDate : Date) -> Int {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.second], from: from, to: toDate)
        let seconds = dateComponents.second
        return Int(seconds!)
    }
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss a"
        return formatter.string(from: self)
    }
    func getTimeDestription() -> String {
        
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
