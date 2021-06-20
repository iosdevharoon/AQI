//
//  HIstoricalDataManager.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import CoreData
import UIKit


class HistoricalDataManager{
    // MARK: Singleton for Module wide access
    static let shared = HistoricalDataManager()
    private init(){}
    // MARK: Getting the reference of default core data manager
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    
    // MARK: Singleton for Module wide access
    func save(city : City){
    
        let request: NSFetchRequest<CityEntity> = NSFetchRequest(entityName: "CityEntity")
        request.fetchLimit = 1
        do {
            request.predicate = NSPredicate(format: "name == %@", city.name)
            let fetchedResult = try managedContext.fetch(request)
            var cityTable: CityEntity
            if fetchedResult.count > 0 {
                
                cityTable = fetchedResult[0]
                
                guard let aqis = cityTable.aqis, let lmts = cityTable.lastModificationTime else { return }
                guard var arrAqis = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(aqis) as? [Double] else { return }
                guard var arrLmt = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(lmts) as? [Date] else { return }
                
                arrAqis.append(contentsOf: city.aqi)
                arrLmt.append(contentsOf: city.lastModificationTime)
                //Restricting AQI to latest 500 points for a better visibilty on Line Chat
                if arrAqis.count > 500{
                    arrAqis = arrAqis.suffix(500)
                }
                if arrLmt.count > 500{
                    arrLmt = arrLmt.suffix(500)
                }
                
                let aqisData = try NSKeyedArchiver.archivedData(withRootObject: arrAqis, requiringSecureCoding: false)
                let lmtData = try NSKeyedArchiver.archivedData(withRootObject: arrLmt, requiringSecureCoding: false)
                
                
                cityTable.name = city.name
                cityTable.aqis = aqisData
                cityTable.lastModificationTime = lmtData
                
            } else {
                
                cityTable = NSEntityDescription.insertNewObject(forEntityName: "CityEntity", into: managedContext) as! CityEntity
                let aqisData = try NSKeyedArchiver.archivedData(withRootObject: city.aqi, requiringSecureCoding: false)
                let lmtData = try NSKeyedArchiver.archivedData(withRootObject: city.lastModificationTime, requiringSecureCoding: false)
                
                cityTable.name = city.name
                cityTable.aqis = aqisData
                cityTable.lastModificationTime = lmtData
            }

        } catch {debugPrint("Error in processing city entity")}
        
        do {
            try managedContext.save()
        } catch{
            debugPrint("Error in saving data City Entity")
        }
    }
    
    // MARK: Fetching all cities data
    //Fetching on background Context to avoid UI Freeze(Lazy loading)
    func fetchAllCities(completionHandler: @escaping ([City]) -> Void) {
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        
        
        privateMOC.perform {
            let fetchRequest =
                NSFetchRequest<CityEntity>(entityName: "CityEntity")
            var retCities = [City]()
            do {
                let cities = try privateMOC.fetch(fetchRequest)
                
                cities.forEach { city in
                    do {
                        guard let arrAqis = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(city.aqis!) as? [Double] else { return }
                        guard let arrLmt = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(city.lastModificationTime!) as? [Date] else { return }
                        guard let name = city.name else { return }
                        let cityy = City(name: name, aqi: arrAqis, lastModificationTime: arrLmt)
                        retCities.append(cityy)
                    } catch {
                        print("Couldn't read file.")
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            completionHandler(retCities)
        }
        
    }
    
}
