//
//  CountryDetailsViewModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/5/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

class CountryDetailsViewModel :CountryDetailsViewModelType {
    
    var errorObservable: Observable<Bool>
    var dataObservable: Observable<[Response]>
    var LoadingObservable: Observable<Bool>
    
    private var countryHistoryAPI:CountryHistoryAPI!
    private var data:[Response]?
    private var datasubject = PublishSubject<[Response]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    private var disposeBag = DisposeBag()
    
    init(){
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
        countryHistoryAPI = CovidAPI.shared
    }
    
    
    func fetchDataWithoutDate(countryName: String) {
        Loadingsubject.onNext(true)
        countryHistoryAPI.getCountryHistoryWithoutDate(countryName: countryName) {[weak self] (result) in
                switch result {
                case .success(let history):
                    self?.data = history?.response
                    self?.datasubject.onNext(self?.data ?? [])
                    self?.Loadingsubject.onCompleted()
                case .failure(let error ):
                    self?.errorsubject.onError(error)
                }
            }

    }
    
    func fetchDataWithDate(countryName: String, day: String) {
        Loadingsubject.onNext(true)
        countryHistoryAPI.getCountryHistoryWithDate(countryName: countryName, date: day) {[weak self] (result) in
                switch result {
                case .success(let history):
                    self?.data = history?.response
                    self?.datasubject.onNext(self?.data ?? [])
                    self?.Loadingsubject.onCompleted()
                case .failure(let error ):
                    self?.errorsubject.onError(error)
                }
            }

    }
    
    
}
