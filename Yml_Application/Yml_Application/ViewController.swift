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
    @IBOutlet weak var ymlLogo: UIImageView!

    override func viewDidLoad() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        super.viewDidLoad()
        setupGUI()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellToReuse", for: indexPath) as? CollectionViewCell
        
        
        let imageToBackGround = UIImage(named: cell?.imageNames[indexPath.row] ?? "nil")
        
        cell?.image.image = UIImage(named: cell?.imageNames[indexPath.row] ?? "nil")
        cell?.productLogo.image = UIImage(named: cell?.productLogoArray[indexPath.row] ?? "nil")
        cell?.productDescription.text = cell?.productDescriptionArray[indexPath.row]
        cell?.productTitle.text = cell?.productTitleArray[indexPath.row]
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func setupGUI(){
        getStartedButton?.layer.cornerRadius = 9.0
        ymlLogo?.layer.cornerRadius = 20.0 //Not Working
        
        //let temp = UICollectionViewFlowLayout()
    }


}

