//
//  CityObservers.swift
//  AQI
//
//  Created by Mohammad Haroon on 20/06/21.
//

import Foundation

//This a special event listener because our server responds array instead of Dictionary
class CityEventObserver {
    var eventHandler: ((_ data : [CityDTO]?, _ errorMessage : String?)->Void)?
    // MARK: takes a closure to send events
    init(eventHandler: ((_ data : [CityDTO]?, _ errorMessage : String?)->Void)?) {
        self.eventHandler  = eventHandler
    }
}
