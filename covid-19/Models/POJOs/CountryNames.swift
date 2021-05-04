//
//  CountryNames.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation

// MARK: - CountryNames
struct CountryNames: Codable {
    let countryResponse: [String]

    enum CodingKeys: String, CodingKey {
        case countryResponse = "response"
    }
}
