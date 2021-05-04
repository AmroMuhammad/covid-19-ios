//
//  CountriesCollectionViewCell.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
//  make outlets private and add observables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
