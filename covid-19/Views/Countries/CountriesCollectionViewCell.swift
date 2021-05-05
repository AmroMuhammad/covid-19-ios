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
            countryImage.sd_setImage(with: URL(string: "https://www.countryflags.io/\(Utils.countryCode(country: countryNameObs))/shiny/64.png"), placeholderImage: UIImage(named: "placeholder"))
        }
    }
//  make outlets private and add observables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
