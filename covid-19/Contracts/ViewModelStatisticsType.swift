//
//  ViewModelType.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    func fetchData()
    var errorObservable: Observable<Bool> {get}
    var LoadingObservable: Observable<Bool> {get}
}

protocol StatisticsViewModelType:ViewModelType{
    var dataObservable:Observable<[Response]> {get}
    var connectivityObservable: Observable<Bool> {get}
}

protocol CountriesViewModelType:ViewModelType {
    var dataObservable:Observable<[String]> {get}
    var searchValue : BehaviorRelay<String> {get}
}

protocol CountryDetailsViewModelType {
    func fetchDataWithoutDate(countryName:String)
    func fetchDataWithDate(countryName:String,day:String)
    func addToCoreData(country:CountryCDModel)
    func checkDataExistanceInCD(countryName : String)->Bool
    func deleteFromCoreData(countryName : String)

    var errorObservable: Observable<Bool> {get}
    var LoadingObservable: Observable<Bool> {get}
    var dataObservable:Observable<[Response]> {get}
}

protocol FavouriteViewModelType : ViewModelType {
    var dataObservable:Observable<[CountryCDModel]> {get}
}
