//
//  CountryDetailsViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountryDetailsViewController: UIViewController {
    private var historyViewModel:CountryDetailsViewModelType!
    private let disposeBag = DisposeBag()
    private var activityView:UIActivityIndicatorView!
    
    @IBOutlet private weak var countryFlagImage: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var countryName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = countryName!
        
        activityView = UIActivityIndicatorView(style: .large)
        historyViewModel = CountryDetailsViewModel()
        
        historyViewModel.dataObservable.subscribe(onNext: { [weak self] (response) in
            let containerVC = self?.children.last as! CountryDetailsTableViewController
            containerVC.updateUI(response: response[0])
            self?.dateLabel.text = response[0].day
            self?.timeLabel.text = (response[0].time!.components(separatedBy: "T")[1].components(separatedBy: "+")[0])+" GMT"
            self?.countryNameLabel.text = self?.countryName
            self?.countryFlagImage.sd_setImage(with: URL(string: "https://www.countryflags.io/\(Utils.countryCode(country: (self?.countryName)!))/shiny/64.png"), placeholderImage: UIImage(named: "placeholder"))
        }).disposed(by: disposeBag)
        
        historyViewModel.errorObservable.subscribe(onError: {[weak self] (error) in
            self?.showErrorMessage(errorMessage: "error")
            }).disposed(by: disposeBag)
        
        historyViewModel.LoadingObservable.subscribe(onNext: {[weak self] (_) in
            self?.showLoading()
        }, onCompleted: {
            self.hideLoading()
            }).disposed(by: disposeBag)
    
        
        historyViewModel.fetchDataWithoutDate(countryName: countryName)
    }
    

    func showLoading() {
        activityView!.center = self.view.center
        self.view.addSubview(activityView!)
        activityView!.startAnimating()
    }
    
    func hideLoading() {
        activityView!.stopAnimating()
    }
    
    func showErrorMessage(errorMessage: String) {
        print(errorMessage)
        let alertController = UIAlertController(title: "Error", message: "Error has Occurred", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }

}
