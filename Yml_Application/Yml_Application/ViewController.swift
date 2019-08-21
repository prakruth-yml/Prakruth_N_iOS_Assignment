//
//  ViewController.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 09/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let numberOfPages = 5
    var tracker = -1

    override func viewDidLoad() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        super.viewDidLoad()
        setupGUI()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////        var tt  = collectionView.indexPathsForVisibleItems.first
////        self.tracker = (tracker+1)%numberOfPages
////        self.pageControl?.currentPage = tracker
////        print("dsav a")
////        print(tt?.row)
//        print("dasvv avs")
//        print(collectionView.indexPath(for: collectionView.visibleCells.first!)!.row)
//        pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row

    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)?.row ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //var tt = collectionView.cellForItem(at: indexPath)
//        if tracker ==
//        var tt  = collectionView.indexPathsForVisibleItems.first
//        self.tracker = (tracker+1)%numberOfPages
//        self.pageControl?.currentPage = tracker
//        print("dsav a")
//        print(tt?.row)
        
//        if {
//            if pageControl.currentPage == indexPath.row {
//                pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
//            }
//        }
//
//        else{
//        }
        
//
//            if let collectionView = collectionView{
//                if pageControl.currentPage == indexPath.row {
//                    pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
//                }
//            }
//            else{
//            }
        
//            pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToReuse", for: indexPath) as? CollectionViewCell
        
        
        let imageToBackGround = UIImage(named: cell?.imageNames[indexPath.row] ?? "nil")
        
        cell?.image.image = UIImage(named: cell?.imageNames[indexPath.row] ?? "nil")
        cell?.layer.cornerRadius = 9.0
        cell?.productLogo.image = UIImage(named: cell?.productLogoArray[indexPath.row] ?? "nil")
        cell?.productLogo.clipsToBounds = true
        cell?.productLogo.layer.cornerRadius = 9.0
        cell?.productDescription.text = cell?.productDescriptionArray[indexPath.row]
//        cell?.productDescription.numberOfLines = 0
        cell?.productDescription.adjustsFontSizeToFitWidth = true
        cell?.productTitle.text = cell?.productTitleArray[indexPath.row]
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func setupGUI(){
        getStartedButton?.layer.cornerRadius = 9.0
        ymlLogoImage?.layer.cornerRadius = 9.0
        collectionView?.isPagingEnabled = true
        ymlLogoImage?.layer.zPosition = 1.0 
        self.collectionView.frame = CGRect()
        pageControl?.numberOfPages = self.numberOfPages
    }


}

