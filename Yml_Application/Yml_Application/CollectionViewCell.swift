//
//  CollectionViewCell.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 20/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productLogo: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    let imageNames = ["", "mobile-70", "home-depot-mobile", "home-mob", "molekule-mobile2"]
    let productLogoArray = ["", "state-farm-logo", "thd-logo", "paypal-logo", "molekule"]
    let productTitleArray = ["Hello", "State Farm", "The Home Depot", "PayPal", "Molekule"]
    let productDescriptionArray = ["We are a design and innovation agency, creating digital products and experiences that have a lasting impact.", "All things insurance, all things banking, all in one app.", "The ultimate power tool: A best-in-class digital experience for The Home Depot.", "Payment giant goes mobile-by-design.", "The world's first intelligent air purifier, & the app putting clean air in people's hands. "]
    
    
    //    @IBOutlet weak var productBackgroundImage: UIImageView!
//    @IBOutlet weak var productLogoImage: UIImageView!
//    @IBOutlet weak var productTitle: UILabel!
//    @IBOutlet weak var productDescription: UILabel!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.backgroundColor = .green
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}
