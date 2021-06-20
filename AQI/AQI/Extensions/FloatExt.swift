//
//  FloatExt.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//

import UIKit
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
