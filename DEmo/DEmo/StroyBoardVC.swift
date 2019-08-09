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
        
        //Function Initializations
        staticTextLabel?.layer.cornerRadius = 7.0
        staticTextLabel?.isUserInteractionEnabled = true
        colorChangeView?.layer.cornerRadius = 7.0
        self.colorChangeView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
        
        
        //
        let staticTextGesture = UITapGestureRecognizer(target: self, action: #selector(StroyBoardVC.didPressLabel(sender: )))
        staticTextLabel.addGestureRecognizer(staticTextGesture)
    }
    
    @objc func didPressLabel(sender: UITapGestureRecognizer){
        
        self.colorChangeView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
        print("Label Press")
    }
    

}
/*NEED TO ADD: CHANGE COLOR WHEN MOVING BETWEEN FOREGROUND AND BACKGROUND USING NOTIFICATIONS*/
