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
