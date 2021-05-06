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
//    func getData(delegate: FavoriteLeaguePresenterProtocol) {
//
//        var leaguesArr = [Country]()
//
//        let appDelegte = UIApplication.shared.delegate as? AppDelegate
//        let context = appDelegte!.persistentContainer.viewContext
//        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeagues")
//        do{
//            let leagues = try context.fetch(fetchReq)
//            for item in leagues {
//                if let leagueId = item.value(forKey: "leagueId"){
//                    if let leagueName = item.value(forKey: "leagueName"){
//                        if let leagueBadge = item.value(forKey: "leagueBadge"){
//                            if let youtubeStr = item.value(forKey: "youtubeStr"){
//                                leaguesArr.append(Country(idLeague: leagueId as? String, idAPIfootball: nil, strSport: nil, strLeague: leagueName as? String, strLeagueAlternate: nil, strDivision: nil, idCup: nil, strCurrentSeason: nil, intFormedYear: nil, dateFirstEvent: nil, strGender: nil, strCountry: nil, strWebsite: nil, strFacebook: nil, strTwitter: nil, strYoutube: youtubeStr as? String, strRSS: nil, strDescriptionEN: nil, strBadge: leagueBadge as? String, strNaming: nil, strLocked: nil))
//                            } else {
//                                print("empty YOUTUBE  GET")
//                            }
//                        } else {
//                            print("empty BADEG  GET")
//                        }
//                    } else {
//                        print("empty NAME  GET")
//                    }
//                } else {
//                    print("empty ID  GET")
//                }
//            }
//        } catch (let err) {
//            print("CAAAAAAAAATCHHHHHHHH  GET")
//            delegate.onFailure(errorMessage: err.localizedDescription)
//        }
//        print("Finish Retrive  GET")
//
//        delegate.onSuccess(leagues: leaguesArr)
//        }
}
