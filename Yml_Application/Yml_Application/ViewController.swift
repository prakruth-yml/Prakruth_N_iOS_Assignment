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
    
    var products: [OnboardScreenData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        setupGUI()
        products = initValues()
    }
    
    //Function to add GUI Initializations
    func setupGUI(){
        getStartedButton?.layer.cornerRadius = 9.0
        ymlLogoImage?.layer.cornerRadius = 9.0
        collectionView?.isPagingEnabled = true
        self.collectionView.frame = CGRect()
        pageControl?.numberOfPages = self.products.count
        pageControl?.pageIndicatorTintColor = .black
        pageControl?.currentPageIndicatorTintColor = .white
    }
    
    //Data Source Functions
    func initValues() -> [OnboardScreenData] {
        return[OnboardScreenData(bgName: "", productLogo: "", productTitle: "Hello", productDesc: "We are a design and innovation agency, creating digital products and experiences that have a lasting impact."), OnboardScreenData(bgName: "mobile-70", productLogo: "state-farm-logo", productTitle: "State Farm", productDesc: "All things insurance, all things banking, all in one app."), OnboardScreenData(bgName: "home-depot-mobile", productLogo: "thd-logo", productTitle: "The Home Depot", productDesc: "The ultimate power tool: A best-in-class digital experience for The Home Depot."), OnboardScreenData(bgName: "home-mob", productLogo: "paypal-logo", productTitle: "PayPal", productDesc: "Payment giant goes mobile-by-design."), OnboardScreenData(bgName: "molekule-mobile2", productLogo: "molekule", productTitle: "Molekule", productDesc: "he world's first intelligent air purifier, & the app putting clean air in people's hands.")]
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    struct OnboardScreenData {
        
        let bgImageName: String
        let productLogoName: String
        let productTitleName: String
        let productDescriptionName: String
        
        init(bgName: String, productLogo: String, productTitle: String, productDesc: String){
            self.bgImageName = bgName
            self.productLogoName = productLogo
            self.productTitleName = productTitle
            self.productDescriptionName = productDesc
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)?.row ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToReuse", for: indexPath) as? CollectionViewCell
        cell?.image.image = UIImage(named: products[indexPath.row].bgImageName)
        cell?.productLogo.image = UIImage(named: products[indexPath.row].productLogoName)
        cell?.productLogo.clipsToBounds = true
        cell?.productLogo.layer.cornerRadius = 9.0
        cell?.productDescription.text = products[indexPath.row].productDescriptionName
        cell?.productDescription.adjustsFontSizeToFitWidth = true
        cell?.productTitle.text = products[indexPath.row].productTitleName
        return cell ?? UICollectionViewCell()
    }
}

