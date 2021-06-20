//
//  NSObject.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
extension NSObject {
    //Providing a computed value so we can use it for find string value of a class
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
