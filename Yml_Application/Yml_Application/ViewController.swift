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
    let numberOfPages = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        setupGUI()
    }
    
    func setupGUI(){
        getStartedButton?.layer.cornerRadius = 9.0
        ymlLogoImage?.layer.cornerRadius = 9.0
        collectionView?.isPagingEnabled = true
        self.collectionView.frame = CGRect()
        pageControl?.numberOfPages = self.numberOfPages
        pageControl?.pageIndicatorTintColor = .black
        pageControl?.currentPageIndicatorTintColor = .white
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)?.row ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToReuse", for: indexPath) as? CollectionViewCell
        cell?.image.image = UIImage(named: cell?.imageNames[indexPath.row] ?? "nil")
        cell?.productLogo.image = UIImage(named: cell?.productLogoArray[indexPath.row] ?? "nil")
        cell?.productLogo.clipsToBounds = true
        cell?.productLogo.layer.cornerRadius = 9.0
        cell?.productDescription.text = cell?.productDescriptionArray[indexPath.row]
        cell?.productDescription.adjustsFontSizeToFitWidth = true
        cell?.productTitle.text = cell?.productTitleArray[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}

