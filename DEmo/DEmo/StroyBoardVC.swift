//
//  StroyBoardVC.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 08/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class StroyBoardVC: UIViewController {

    @IBOutlet weak var staticTextLabel: UILabel!
    @IBOutlet weak var colorChangeView: UIView!
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @IBAction func backButtonDidPress(button: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }

    func setupUI(){
        
        staticTextLabel?.layer.cornerRadius = 7.0
    }
    

}
