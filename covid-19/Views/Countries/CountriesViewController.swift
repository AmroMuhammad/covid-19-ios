//
//  CountriesViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/4/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesViewController: UIViewController {
    private var countriesViewModel:CountriesViewModelType!
    private let disposeBag = DisposeBag()
    private var activityView:UIActivityIndicatorView!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var countriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register nib cell
        let nibCell = UINib(nibName: Constants.countriesNibCell, bundle: nil)
        countriesCollectionView.register(nibCell, forCellWithReuseIdentifier: Constants.countriesNibCell)
        
        //viewModel
        activityView = UIActivityIndicatorView(style: .large)
        countriesViewModel = CountriesViewModel()
        
        countriesCollectionView.rx.setDelegate(self)
        
        countriesViewModel.dataObservable.bind(to: countriesCollectionView.rx.items(cellIdentifier: Constants.countriesNibCell)){row,item,cell in
           let castedCell = cell as! CountriesCollectionViewCell
            castedCell.countryName.text = item
        }.disposed(by: disposeBag)
        
        countriesViewModel.errorObservable.subscribe(onError: {[weak self] (error) in
            self?.showErrorMessage(errorMessage: "error")
            }).disposed(by: disposeBag)
        
        countriesViewModel.LoadingObservable.subscribe(onNext: {[weak self] (_) in
            self?.showLoading()
        }, onCompleted: {
            self.hideLoading()
            }).disposed(by: disposeBag)
        
        countriesViewModel.fetchData()
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

extension CountriesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 75, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 2.5
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

