//
//  ApplicationNetworking.swift
//  Sportify
//
//  Created by Amr Muhammad on 4/27/21.
//  Copyright © 2021 ITI-41. All rights reserved.
//

import Foundation
import Alamofire

enum ApplicationNetworking{
    case getWorldStatistics(country:String)
}

extension ApplicationNetworking : TargetType {
    var baseURL: String {
        switch self {
        default:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getWorldStatistics:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWorldStatistics:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWorldStatistics(let country):
            return .requestParameters(parameters: ["country":country], encoding: URLEncoding.default)   //for get,head or delete use URLEncoding.default
        }
    }
    
    var headers: [String : String]? {
        return ["x-rapidapi-key": "dfdcc3080dmsh9ed895764f8da69p16047cjsn1049ba2dd326",
        "x-rapidapi-host": "covid-193.p.rapidapi.com"]
    }
    
    
}
