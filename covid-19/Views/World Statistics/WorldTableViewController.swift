//
//  WorldTableViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WorldTableViewController: UITableViewController {
    
    @IBOutlet private weak var newCasesLabel: UILabel!
    @IBOutlet private weak var activeCasesLabel: UILabel!
    @IBOutlet private weak var criticalCasesLabel: UILabel!
    @IBOutlet private weak var recoveredCasesLabel: UILabel!
    @IBOutlet private weak var totalCasesLabel: UILabel!
    
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 5
        default:
            return 2
        }
    }

    func updateUI(response:Response){
        newCasesLabel.text = response.cases.new
        activeCasesLabel.text = String(response.cases.active!)
        criticalCasesLabel.text = String(response.cases.critical!)
        recoveredCasesLabel.text = String(response.cases.recovered!)
        totalCasesLabel.text = String(response.cases.total!)

        newDeathsLabel.text = String(response.deaths.new ?? "")
        totalDeathsLabel.text = String(response.deaths.total!)


    }


}
