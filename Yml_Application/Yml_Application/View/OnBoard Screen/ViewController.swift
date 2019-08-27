//
//  ViewController.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 09/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewModel = OnBoardScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        viewModel.getValues()
        setupGUI()
    }
    
    //Function to add GUI Initializations
    func setupGUI(){
        getStartedButton?.layer.cornerRadius = 9.0
        ymlLogoImage?.layer.cornerRadius = 9.0
        collectionView?.isPagingEnabled = true
        self.collectionView.frame = CGRect()
        pageControl?.numberOfPages = viewModel.onBoardScreenData.count
        pageControl?.pageIndicatorTintColor = .black
        pageControl?.currentPageIndicatorTintColor = .white
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.onBoardScreenData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell
        cell?.image.image = UIImage(named: viewModel.onBoardScreenData[indexPath.row].bgImageName)
        cell?.productLogo.image = UIImage(named: viewModel.onBoardScreenData[indexPath.row].productLogoName)
        cell?.productLogo.clipsToBounds = true
        cell?.productLogo.layer.cornerRadius = 9.0
        cell?.productDescription.text = viewModel.onBoardScreenData[indexPath.row].productDescriptionName
        cell?.productDescription.adjustsFontSizeToFitWidth = true
        cell?.productTitle.text = viewModel.onBoardScreenData[indexPath.row].productTitleName
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)?.row ?? 0
    }
}


