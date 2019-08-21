//
//  ViewController.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 09/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var ymlLogoImage: UIImageView!

    override func viewDidLoad() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        super.viewDidLoad()
        setupGUI()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
    }


}

