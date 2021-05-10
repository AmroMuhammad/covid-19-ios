//
//  LocalManager.swift
//  Sportify
//
//  Created by Amr Muhammad on 06/05/2021.
//  Copyright © 2021 ITI-41. All rights reserved.
//

import UIKit
import CoreData

class LocalManager {
    
    static let sharedInstance = LocalManager()
    
    private init(){}
    
    func checkData(countryName: String)->Bool {
        let appDelegte: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegte.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.coreDataName)
        do{
            let countries = try context.fetch(fetchReq)
            for item in countries {
                if let country = item.value(forKey: "countryName"){
                    if country as! String == countryName{
                        print("data found in coreData")
                        return true
                        break
                    } else {
                        print("data not found in coreData")
                    }
                } else {
                    print("null in checkData")
                }
            }
            return false
        } catch {
            print("try error in checkData")
        }
        return false
    }
    
    func addData(countryObject: CountryCDModel) {
        
        let appDelegte = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegte.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Constants.coreDataName, in: context)
        let countryCDObj = NSManagedObject(entity: entity!, insertInto: context)
        
        countryCDObj.setValue(countryObject.countryName, forKey: "countryName")
        countryCDObj.setValue(countryObject.date, forKey: "date")
        countryCDObj.setValue(countryObject.time, forKey: "time")
        countryCDObj.setValue(countryObject.newCases, forKey: "newCases")
        countryCDObj.setValue(countryObject.activeCases, forKey: "activeCases")
        countryCDObj.setValue(countryObject.recoveredCases, forKey: "recoveredCases")
        countryCDObj.setValue(countryObject.criticalCases, forKey: "criticalCases")
        countryCDObj.setValue(countryObject.totalCases, forKey: "totalCases")
        countryCDObj.setValue(countryObject.newDeaths, forKey: "newDeaths")
        countryCDObj.setValue(countryObject.totalDeaths, forKey: "totalDeaths")
        
        do{
            try context.save()
            print("\nDataAddedToLocal")
        } catch {
            print("CATCH WHEN SAVE")
        }
    }
    
    func deleteData(countryName: String) {
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.coreDataName)
        do{
            let countryObjs = try context.fetch(fetchReq)
            for item in countryObjs {
                if let country = item.value(forKey: "countryName"){
                    if country as! String == countryName{
                        context.delete(item)
                        try context.save()
                        print("\nDataDeletedFromLocal")
                        break
                    } else {
                        print("didnt found data in delete")
                    }
                } else {
                    print("null in delete")
                }
            }
        } catch {
            print("try error in delete")
        }
        print("Finish Removing  DLT")
    }
    //
    func getData()-> [CountryCDModel]{
        var countriesArray = [CountryCDModel]()
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.coreDataName)
        do{
            let countries = try context.fetch(fetchReq)
            for item in countries {
                guard let countryName = item.value(forKey: "countryName") as? String else {
                      print("Empty country name, or not string")
                      return countriesArray
                }
                guard let date = item.value(forKey: "date") as? String else {
                      print("Empty date, or not string")
                      return countriesArray
                }
                guard let time = item.value(forKey: "time") as? String else {
                      print("Empty time, or not string")
                      return countriesArray
                }
                guard let newCases = item.value(forKey: "newCases") as? String else {
                      print("Empty newCases, or not string")
                      return countriesArray
                }
                guard let activeCases = item.value(forKey: "activeCases") as? String else {
                      print("Empty activeCases, or not string")
                      return countriesArray
                }
                guard let recoveredCases = item.value(forKey: "recoveredCases") as? String else {
                      print("Empty recoveredCases, or not string")
                      return countriesArray
                }
                guard let criticalCases = item.value(forKey: "criticalCases") as? String else {
                      print("Empty criticalCases, or not string")
                      return countriesArray
                }
                guard let totalCases = item.value(forKey: "totalCases") as? String else {
                      print("Empty totalCases, or not string")
                      return countriesArray
                }
                guard let newDeaths = item.value(forKey: "newDeaths") as? String else {
                      print("Empty newDeaths, or not string")
                      return countriesArray
                }
                guard let totalDeaths = item.value(forKey: "totalDeaths") as? String else {
                      print("Empty totalCases, or not string")
                      return countriesArray
                }
                 countriesArray.append(CountryCDModel(countryName: countryName, date: date, time: time, newCases: newCases, activeCases: activeCases, criticalCases: criticalCases, recoveredCases: recoveredCases, totalCases: totalCases, newDeaths: newDeaths, totalDeaths: totalDeaths))
            }
        } catch (_) {
            print("CAAAAAAAAATCHHHHHHHH")
            return countriesArray
        }
        print("Finish Retrive  GET")
        return countriesArray
    }
}
