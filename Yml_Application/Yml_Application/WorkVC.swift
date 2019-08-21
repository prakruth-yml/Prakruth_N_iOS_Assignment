//
//  AboutUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WorkVC: UITabBarController, UITabBarControllerDelegate {

    var aboutUsVC: AboutUsVC?
    var newsVC: NewsVC?
    var carrersVC: CarrersVC?
    var contactUsVC: ContactUsVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.selectedViewController = self
        tabBarController?.selectedIndex = 0
        tabBarController?.viewControllers = [aboutUsVC, newsVC, carrersVC, contactUsVC] as? [UIViewController]
        // Do any additional setup after loading the view.
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
