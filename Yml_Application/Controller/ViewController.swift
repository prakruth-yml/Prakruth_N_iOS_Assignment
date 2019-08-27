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
    
    //Data Source Functions
    

}

