//
//  CityObservers.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//

import Foundation
class CityEventObserver{
    var eventHandler: ((_ data : [CityDTO]?, _ errorMessage : String?)->Void)?
    
    init(eventHandler: ((_ data : [CityDTO]?, _ errorMessage : String?)->Void)?) {
        self.eventHandler  = eventHandler
    }
}
