//
//  CountriesViewModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

class CountriesViewModel : CountriesViewModelType {
    var dataObservable: Observable<[String]>
    var errorObservable: Observable<Bool>
    var LoadingObservable: Observable<Bool>
    
    private var countriesAPI:CountriesAPI!
    private var data:[String]?
    private var datasubject = PublishSubject<[String]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    
    init(){
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
        countriesAPI = CovidAPI.shared
    }
    
    func fetchData() {
        Loadingsubject.onNext(true)
        countriesAPI.getCountries { [weak self] (result) in
            switch result{
            case .success(let countries):
                self?.data = countries?.countryResponse
                self?.datasubject.onNext(self?.data ?? [])
                self?.Loadingsubject.onCompleted()
            case .failure(let error):
                self?.errorsubject.onError(error)
            }
        }
    }
    
}
