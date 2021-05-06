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
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var dateRecieved:Date = Date()
    let dateFormatter = DateFormatter()
    
    @IBOutlet private weak var countryFlagImage: UIImageView!
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var calenderButton: UIBarButtonItem!
    
    var countryName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = countryName!
        
        activityView = UIActivityIndicatorView(style: .large)
        historyViewModel = CountryDetailsViewModel()
        
        historyViewModel.dataObservable.subscribe(onNext: { [weak self] (response) in
            let containerVC = self?.children.last as! CountryDetailsTableViewController
            if(response.isEmpty){
                self?.showErrorMessage(errorMessage: "No data Available in this day")
            }else{
                containerVC.updateUI(response: response[0])
                self?.dateLabel.text = response[0].day
                self?.timeLabel.text = (response[0].time!.components(separatedBy: "T")[1].components(separatedBy: "+")[0])+" GMT"
                self?.countryNameLabel.text = self?.countryName
                self?.countryFlagImage.sd_setImage(with: URL(string: "https://www.countryflags.io/\(Utils.countryCode(country: (self?.countryName)!))/shiny/64.png"), placeholderImage: UIImage(named: "placeholder"))
            }
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
        var alertController = UIAlertController()
        if errorMessage == "" {
            alertController = UIAlertController(title: "Error", message: "Error has Occurred", preferredStyle: .alert)
        }
        else{
            alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showCalender(_ sender: UIBarButtonItem) {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick)),UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.onCancelButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = sender?.date {
            dateRecieved = date
        }
    }
    
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        print("Picked the date \(dateFormatter.string(from: self.dateRecieved))")
        historyViewModel.fetchDataWithDate(countryName: countryName, day: "\(dateFormatter.string(from: self.dateRecieved))")
    }
    
    @objc func onCancelButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
}
