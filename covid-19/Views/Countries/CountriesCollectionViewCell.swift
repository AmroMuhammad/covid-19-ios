//
//  CountriesCollectionViewCell.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var countryImage: UIImageView!
    @IBOutlet private weak var countryName: UILabel!
    var countryNameObs = "" {
        didSet{
            countryName.text = countryNameObs
            countryImage.sd_setImage(with: URL(string: "https://www.countryflags.io/\(self.countryCode(country: countryNameObs))/shiny/64.png"), placeholderImage: UIImage(named: "placeholder"))
        }
    }
//  make outlets private and add observables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func countryCode(country:String)->String{
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
