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
    var connectivityObservable: Observable<Bool>
    var dataObservable: Observable<[Response]>
    var errorObservable: Observable<Bool>
    var LoadingObservable: Observable<Bool>
    
    private let covidAPI:StatisticsAPI!
    private var data:[Response]?
    private var datasubject = PublishSubject<[Response]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    private var connectivitySubject = PublishSubject<Bool>()

    init(){
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
        connectivityObservable = connectivitySubject.asObservable()
        covidAPI = CovidAPI.shared
    }
    
    func fetchData() {
        if(!Connectivity.isConnectedToInternet){
            connectivitySubject.onError(NSError(domain:"noInternet", code:0, userInfo:nil))
            return
        }
        Loadingsubject.onNext(true)
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
