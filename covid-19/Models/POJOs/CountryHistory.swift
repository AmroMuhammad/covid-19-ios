//
//  CountryHistory.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation

// MARK: - CountryHistory
struct CountryHistory: Codable {
    let responseHistory: [HistoryResponse]

    enum CodingKeys: String, CodingKey {
        case responseHistory = "response"
    }
}


// MARK: - Response
struct HistoryResponse: Codable {
    let continent, country: String
    let population: Int
    let cases: Cases
    let deaths: Deaths
    let day: String
    let time: String
}










