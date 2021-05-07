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
                if let countryName = item.value(forKey: "countryName"){
                    if let date = item.value(forKey: "date"){
                        if let time = item.value(forKey: "time"){
                            if let newCases = item.value(forKey: "newCases"){
                                if let activeCases = item.value(forKey: "activeCases"){
                                    if let recoveredCases = item.value(forKey: "recoveredCases"){
                                        if let criticalCases = item.value(forKey: "criticalCases"){
                                            if let totalCases = item.value(forKey: "totalCases"){
                                                if let newDeaths = item.value(forKey: "newDeaths"){
                                                    if let totalDeaths = item.value(forKey: "totalDeaths"){
                                                        countriesArray.append(CountryCDModel(countryName: countryName as! String, date: date as! String, time: time as! String, newCases: newCases as! String, activeCases: activeCases as! String, criticalCases: criticalCases as! String, recoveredCases: recoveredCases as! String, totalCases: totalCases as! String, newDeaths: newDeaths as! String, totalDeaths: totalDeaths as! String))
                                                    }else{
                                                        print("empty total deaths")
                                                    }
                                                }else{
                                                    print("empty new deaths")
                                                }
                                            }else{
                                                print("empty total cases")
                                            }
                                        }else{
                                            print("empty critical ")
                                        }
                                    }else{
                                        print("empty recovered")
                                    }
                                }else{
                                    print("empty active")
                                }
                            } else {
                                print("empty newCases")
                            }
                        } else {
                            print("empty time")
                        }
                    } else {
                        print("empty date")
                    }
                } else {
                    print("empty countryName")
                }
            }
        } catch (_) {
            print("CAAAAAAAAATCHHHHHHHH  GET")
            return countriesArray
        }
        print("Finish Retrive  GET")
        return countriesArray
    }
}
