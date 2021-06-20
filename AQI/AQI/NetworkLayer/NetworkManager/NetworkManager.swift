//
//  NetworkManager.swift
//  AQI
//
//  Created by Mohammad Haroon on 18/06/21.
//

import Foundation
import Starscream
class NetworkManager{
    //Constants
    struct API {
        static let baseURL = URL(string:"ws://city-ws.herokuapp.com/")!
    }
    //Instance variables
    static let shared = NetworkManager(baseURL: API.baseURL)
    private let baseURL: URL
    private var socket : WebSocket!
    private var isConnected = false
    private var listeners = [KeyEventObserver]()
    private var cityListners = [CityEventObserver]()
    private init(baseURL: URL) {
        self.baseURL = baseURL
        self.initialize()
    }
    private func initialize(){
        var request = URLRequest(url: API.baseURL)
        request.timeoutInterval = 60
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    func startConnection(){
        if !isConnected{
            socket.connect()
        }
    }
    func endConnection(){
        socket.disconnect()
    }
    func addKeyObserver(observer : KeyEventObserver){
        self.listeners.append(observer)
    }
    func removeKeyObserver(observer : KeyEventObserver){
        self.listeners.removeAll { _observer in
            _observer === observer
        }
    }
    func addCityObserver(observer : CityEventObserver){
        self.cityListners.append(observer)
    }
    func removeCityObserver(observer : CityEventObserver){
        self.cityListners.removeAll { _observer in
            _observer === observer
        }
    }
    
}
extension NetworkManager : WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                debugPrint("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                debugPrint("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                debugPrint("Received text: \(string)")
                let data = Data(string.utf8)
                do{
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        //JSON is a dictionary and we will find data based on the event names here.
                        for observer in listeners{
                            if let info = response[observer.eventName] as? [String : Codable]{
                                do {
                                    let eventData = try JSONSerialization.data(withJSONObject: info, options: JSONSerialization.WritingOptions.prettyPrinted)
                                    observer.eventHandler?(eventData,nil)
                                } catch {
                                    observer.eventHandler?(nil,error.localizedDescription)
                                    debugPrint(error.localizedDescription)
                                    return
                                }
                            }
                            
                        }
                    } else if let _ = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]{
                        //JSON is a array hence no key value thing happening here.
                        for observer in cityListners{
                            let cities = try! JSONDecoder().decode([CityDTO].self, from: data)
                            observer.eventHandler?(cities, nil)
                        }
                    }
                    
                }
                catch {
                    print(error.localizedDescription)
                }
                
                
                
            case .binary(let data):
                debugPrint("Received data: \(data.count)")
                
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                debugPrint(error?.localizedDescription ?? "Something went wrong")
            }
    }
    
    
}
