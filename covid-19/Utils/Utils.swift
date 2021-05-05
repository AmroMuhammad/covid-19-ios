//
//  Reachabilityy.swift
//  Sportify
//
//  Created by Amr Muhammad on 4/22/21.
//  Copyright © 2021 ITI-41. All rights reserved.
//

import Foundation
import Alamofire

struct Connectivity {
    private init() {}
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}



extension UIImageView{
    func roundImage(){
        self.layer.cornerRadius = self.frame.size.width/2.0
        self.layer.borderColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        self.layer.borderWidth = 2.0
    }
}

struct Utils{
    static func countryCode(country:String)->String{
        let url = Bundle.main.url(forResource: "country", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let jsonSerialize = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[[String:String]]]
                
            let arr = jsonSerialize!["countries"]!
            
            for dict1 in arr {
                for (key, value) in dict1 {
                    if(key == country){
                        return(value)
                    }
                }
            }
            return "error"
        }
        catch {
            print(error)
            return ""
        }
    }
}
