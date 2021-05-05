//
//  SportsAPI.swift
//  Sportify
//
//  Created by Amr Muhammad on 4/27/21.
//  Copyright © 2021 ITI-41. All rights reserved.
//

import Foundation
class CovidAPI : BaseAPI<ApplicationNetworking>,StatisticsAPI{
    
    static let shared = CovidAPI()
    
    private override init() {}
    
    func getWorldStatistics(countryName:String,completion: @escaping (Result<StatisticsModel?,NSError>) -> Void){
        self.fetchData(target: .getWorldStatistics(country: countryName), responseClass: StatisticsModel.self) { (result) in
            completion(result)
        }
    }
}

extension CovidAPI : CountriesAPI {
    func getCountries(completion: @escaping (Result<CountryNames?, NSError>) -> Void) {
        self.fetchData(target: .getCountriesStatistics, responseClass: CountryNames.self) { (result) in
            completion(result)
        }
    }
}

extension CovidAPI : CountryHistoryAPI{
    func getCountryHistoryWithoutDate(countryName: String, completion: @escaping (Result<StatisticsModel?, NSError>) -> Void) {
        self.fetchData(target: .countryHistoryWithoutDate(country: countryName), responseClass: StatisticsModel.self) { (result) in
            completion(result)
        }
    }
    
    func getCountryHistoryWithDate(countryName: String, date: String, completion: @escaping (Result<StatisticsModel?, NSError>) -> Void) {
        fetchData(target: .countryHistoryWithDate(country: countryName, date: date), responseClass: StatisticsModel.self) { (result) in
            completion(result)
        }
    }
    
    
    
}
