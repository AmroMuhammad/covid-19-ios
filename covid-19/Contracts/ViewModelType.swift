//
//  ViewModelType.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelType {
    func fetchData()
    var dataObservable:Observable<[Response]> {get}
    var errorObservable: Observable<Bool> {get}
    var LoadingObservable: Observable<Bool> {get}
}
