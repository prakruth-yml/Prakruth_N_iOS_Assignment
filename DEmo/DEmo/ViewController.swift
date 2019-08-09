//
//  ViewController.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 08/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var buttonInVC: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var storyTransitButton: UIButton!
    @IBOutlet weak var codeTransitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpUI()

    }
    
    @IBAction func storyTransitButtonDidPress(buttonElement: UIButton){
        
        print("Button Pressed \(buttonElement.currentTitle ?? "nil")")
    }
    
    func setUpUI(){
        
        titleLabel?.layer.cornerRadius = 5.0
        logoImage?.layer.cornerRadius = 7.0
        storyTransitButton?.layer.cornerRadius = 7.0
        codeTransitButton?.layer.cornerRadius = 7.0
    }
}

