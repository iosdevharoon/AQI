//
//  UIViewController.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit
extension UIViewController {
    static var storyboardID: String {
        return className
    }
    
    static func loadFromNib<T: UIViewController>(_: T.Type) -> T {
        return T.init(nibName: String(describing: T.self), bundle: nil)
    }
    
    
    func displayAlert(withMessage alertMessage: String) {
        let alert = UIAlertController(title: "AQI Message", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
