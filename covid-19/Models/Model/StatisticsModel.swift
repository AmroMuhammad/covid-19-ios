//
//  StatisticsModel.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation

// MARK: - Statistics
struct StatisticsModel: Codable {
    let results: Int
    let response: [Response]

    enum CodingKeys: String, CodingKey {
        case results, response
    }
}

// MARK: - Response
struct Response: Codable {
    let country: String?
    let cases: Cases
    let deaths: Deaths
    let day: String?
    let time: String?
}

// MARK: - Cases
struct Cases: Codable {
    let new: String?
    let active, critical, recovered, total: Int?
}

// MARK: - Deaths
struct Deaths: Codable {
    let new: String?
    let total: Int?
}

