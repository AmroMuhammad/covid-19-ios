//
//  StatisticsAPI.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
protocol StatisticsAPI {
    func getWorldStatistics(countryName:String,completion: @escaping (Result<StatisticsModel?,NSError>) -> Void)
}
