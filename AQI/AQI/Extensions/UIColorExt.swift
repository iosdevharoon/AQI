//
//  GeneralExtensions.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import Foundation
import UIKit

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
