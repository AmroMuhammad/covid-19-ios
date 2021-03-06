//
//  WorldViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/2/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorldViewController: UIViewController {
    private var worldViewModel:StatisticsViewModelType!
    private let disposeBag = DisposeBag()
    private var activityView:UIActivityIndicatorView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
       
    @IBOutlet weak var noConnectionImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Covid-19 Tracker"
        activityView = UIActivityIndicatorView(style: .large)
        worldViewModel = WorldViewModel()

        worldViewModel.dataObservable.subscribe(onNext: { [weak self] (response) in
            let containerVC = self?.children.last as! WorldTableViewController
            containerVC.updateUI(response: response[0])
            self?.updateUI(response: response[0])
        }).disposed(by: disposeBag)
        
        worldViewModel.errorObservable.subscribe(onError: {[weak self] (error) in
            self?.showErrorMessage(errorMessage: "error")
            }).disposed(by: disposeBag)
        
        worldViewModel.LoadingObservable.subscribe(onNext: {[weak self] (_) in
            self?.showLoading()
        }, onCompleted: {
            self.hideLoading()
            }).disposed(by: disposeBag)
        
        worldViewModel.connectivityObservable.subscribe(onError: {[weak self] (error) in
            self?.hideLoading()
            self?.noConnectionImage.isHidden = false
            self?.showErrorMessage(errorMessage: "")
            }).disposed(by: disposeBag)
        
        worldViewModel.fetchData()
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
        let alertController = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(response:Response){
        self.dateLabel.text = response.day
        self.timeLabel.text = (response.time?.components(separatedBy: "T")[1].components(separatedBy: "+")[0] ?? "")+" GMT"
    }

}
