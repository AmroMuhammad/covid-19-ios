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
import SDWebImage

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
        
        countriesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        countriesViewModel.dataObservable.bind(to: countriesCollectionView.rx.items(cellIdentifier: Constants.countriesNibCell)){row,item,cell in
           let castedCell = cell as! CountriesCollectionViewCell
            castedCell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            castedCell.layer.borderWidth = 2
            castedCell.countryNameObs = item
        }.disposed(by: disposeBag)
        
        countriesViewModel.errorObservable.subscribe(onError: {[weak self] (error) in
            self?.showErrorMessage(errorMessage: "error")
            }).disposed(by: disposeBag)
        
        countriesViewModel.LoadingObservable.subscribe(onNext: {[weak self] (_) in
            self?.showLoading()
        }, onCompleted: {
            self.hideLoading()
            }).disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty.debug().distinctUntilChanged().bind(to: countriesViewModel.searchValue).disposed(by: disposeBag)
        
        countriesCollectionView.rx.modelSelected(String.self).subscribe(onNext: {[weak self] (value) in
            let detailsVC = self?.storyboard?.instantiateViewController(identifier: Constants.countryDetailsVC) as! CountryDetailsViewController
            detailsVC.countryName = value
            self?.navigationController?.pushViewController(detailsVC, animated: true)
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
        return CGSize(width: 110, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset/2, bottom: inset, right: inset/2)
    }
}

