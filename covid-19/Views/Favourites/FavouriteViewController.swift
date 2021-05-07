//
//  FavouriteViewController.swift
//  covid-19
//
//  Created by Amr Muhammad on 5/7/21.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteViewController: UIViewController{
    private var favouriteViewModel:FavouriteViewModelType!
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    private var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Covid-19 Tracker"

        //register nibFile
        let nibCell = UINib(nibName: Constants.countriesNibCell, bundle: nil)
        favouriteCollectionView.register(nibCell, forCellWithReuseIdentifier: Constants.countriesNibCell)
        
        //viewModel
        activityView = UIActivityIndicatorView(style: .large)
        favouriteViewModel = FavouriteViewModel()
        
        favouriteCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        favouriteViewModel.dataObservable.bind(to: favouriteCollectionView.rx.items(cellIdentifier: Constants.countriesNibCell)){row,item,cell in
            let castedCell = cell as! CountriesCollectionViewCell
            castedCell.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            castedCell.layer.borderWidth = 2
            castedCell.countryNameObs = item.countryName
            
        }.disposed(by: disposeBag)
        
        favouriteViewModel.LoadingObservable.subscribe(onNext: {[weak self] (_) in
            self?.showLoading()
        }, onCompleted: {
            self.hideLoading()
            }).disposed(by: disposeBag)
        
        favouriteCollectionView.rx.modelSelected(CountryCDModel.self).subscribe(onNext: {[weak self] (value) in
            let detailsVC = self?.storyboard?.instantiateViewController(identifier: Constants.countryDetailsVC) as! CountryDetailsViewController
            detailsVC.countryName = value.countryName
            detailsVC.comingFrom = "favourite"
            detailsVC.recievedCountryObject = value
            self?.navigationController?.pushViewController(detailsVC, animated: true)
        }).disposed(by: disposeBag)
        
        favouriteViewModel.fetchData()
    }
    
    func showLoading() {
        activityView!.center = self.view.center
        self.view.addSubview(activityView!)
        activityView!.startAnimating()
    }
    
    func hideLoading() {
        activityView!.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteViewModel.fetchData()
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 110, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset/2, bottom: inset, right: inset/2)
    }
}
