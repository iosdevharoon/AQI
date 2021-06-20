//
//  Binding.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//
///This class can be used to bind a value with a closure.
///We did this in City List Controller.
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

