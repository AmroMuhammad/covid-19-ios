//
//  CountryDetailsTableViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit

class CountryDetailsTableViewController: UITableViewController {
    @IBOutlet private weak var newCasesLabel: UILabel!
    @IBOutlet private weak var activeCasesLabel: UILabel!
    @IBOutlet private weak var criticalCasesLabel: UILabel!
    @IBOutlet private weak var recoveredCasesLabel: UILabel!
    @IBOutlet private weak var totalCasesLabel: UILabel!
    @IBOutlet weak var newDeathLabel: UILabel!
    @IBOutlet weak var totalDeathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        activeCasesLabel.text = String(response.cases.active ?? 0)
        criticalCasesLabel.text = String(response.cases.critical ?? 0)
        recoveredCasesLabel.text = String(response.cases.recovered ?? 0)
        totalCasesLabel.text = String(response.cases.total ?? 0)
        newDeathLabel.text = response.deaths.new
        totalDeathLabel.text = String(response.deaths.total ?? 0)

    }

    

}
