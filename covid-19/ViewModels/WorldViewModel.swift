//
//  WorldViewModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

class WorldViewModel : ViewModelType {
    
    var dataObservable: Observable<[Response]>
    var errorObservable: Observable<Bool>
    var LoadingObservable: Observable<Bool>
    
    private let covidAPI:StatisticsAPI!
    private var data:[Response]?
    private var datasubject = PublishSubject<[Response]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    
    init(){
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
        Loadingsubject.onNext(true)
        errorsubject.onNext(false)
        covidAPI = CovidAPI.shared
    }
    
    func fetchData() {
        covidAPI.getWorldStatistics(countryName: "all") { [weak self] (result) in
            switch result{
            case .success(let stats):
                self?.data = stats?.response
                self?.datasubject.onNext(self?.data ?? [])
                self?.Loadingsubject.onCompleted()
            case .failure(let error):
                self?.errorsubject.onError(error)
            }
        }
    }
    
}
