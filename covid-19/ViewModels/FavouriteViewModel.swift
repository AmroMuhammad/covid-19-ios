//
//  FavouriteViewModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/7/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

class FavouriteViewModel : FavouriteViewModelType {
    var dataObservable: Observable<[CountryCDModel]>
    var errorObservable: Observable<Bool>
    var LoadingObservable: Observable<Bool>
    
    private var data:[CountryCDModel]?
    private var datasubject = PublishSubject<[CountryCDModel]>()
    private var errorsubject = PublishSubject<Bool>()
    private var Loadingsubject = PublishSubject<Bool>()
    private var disposeBag = DisposeBag()
    private var localManager:LocalManager!
    
    init(){
        localManager = LocalManager.sharedInstance
        dataObservable = datasubject.asObservable()
        LoadingObservable = Loadingsubject.asObservable()
        errorObservable = errorsubject.asObservable()
    }
    
    func fetchData() {
        Loadingsubject.onNext(true)
        data = localManager.getData()
        datasubject.onNext(data ?? [])
        self.Loadingsubject.onCompleted()
    }
    
}
