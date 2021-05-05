//
//  CountryDetailsViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    @IBOutlet private weak var countryFlagImage: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var countryName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName!
        CovidAPI.shared.getCountryHistory(countryName: countryName!, date: "2021-05-04") { (result) in
            switch result{
            case .success(let history):
                print(history)
            case .failure(_):
                print("ere")
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
