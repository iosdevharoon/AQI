//
//  NSObject.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
