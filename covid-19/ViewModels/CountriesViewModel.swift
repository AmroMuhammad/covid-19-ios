//
//  CountriesViewModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CountriesViewModel : CountriesViewModelType {
    var dataObservable: Observable<[String]>
    var errorObservable: Observable<Bool>
    var LoadingObservable: Observable<Bool>
    var searchValue : BehaviorRelay<String> = BehaviorRelay(value: "")
    
    private lazy var searchValueObservable:Observable<String> = searchValue.asObservable()
    private var countriesAPI:CountriesAPI!
    private var data:[String]?
    private var datasubject = PublishSubject<[String]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    private var disposeBag = DisposeBag()
    
    init(){
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
        countriesAPI = CovidAPI.shared
        
        searchValueObservable.subscribe(onNext: {[weak self] (value) in
            print("value is \(value)")
            let filteredData = self?.data?.filter({ (country) -> Bool in
                country.lowercased().prefix(value.count) == value.lowercased()
            })
            self?.datasubject.onNext(filteredData ?? [])
            }).disposed(by: disposeBag)
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
