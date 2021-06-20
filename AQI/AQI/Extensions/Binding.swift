//
//  Binding.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//

import Foundation
class Binding<T> {
    
    var value : T {
        didSet{
            handler?(value)
        }
    }
    var handler : ((T) -> Void)?
    
    init(value : T){
        self.value = value
    }
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        handler = closure
    }
}

