//
//  AboutUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WorkVC: UIViewController{
    
    @IBOutlet weak var homePageImage: UIImageView!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGUI()
    }
    
    func setupGUI(){
//        ymlLogoImage.layer.cornerRadius = 12.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
