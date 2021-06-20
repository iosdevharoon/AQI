//
//  KeyObservers.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//

import Foundation
class KeyEventObserver{
    
    var eventName : String = ""
    var eventHandler: ((_ data : Data?, _ errorMessage : String?)->Void)?
    
    init(eventName : String, eventHandler: ((_ data : Data?, _ errorMessage : String?)->Void)?) {
        self.eventName = eventName
        self.eventHandler  = eventHandler
    }
}
