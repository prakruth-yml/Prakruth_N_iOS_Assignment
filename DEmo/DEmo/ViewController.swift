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
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpUI()

    }
    
    @IBAction func storyTransitButtonDidPress(buttonElement: UIButton){
        
        print("Button Pressed \(buttonElement.currentTitle ?? "nil")")
    }
    
    @IBAction func codeTransitButtonDidPress(buttonElement: UIButton){
        
        print("Button Pressed \(buttonElement.currentTitle ?? "nil")")
//        var newVC = UIViewController()
//        self.navigationController?.pushViewController(newVC, animated: true)
        
//        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        var newVC = storyBoard.instantiateViewController(withIdentifier: "CodeTransit") as! ViaProgramVC
//        self.navigationController?.pushViewController(newVC, animated: true)
        
        
        
    }
    
    func setUpUI(){
        
        titleLabel?.layer.cornerRadius = 5.0
        logoImage?.layer.cornerRadius = 7.0
        storyTransitButton?.layer.cornerRadius = 7.0
        codeTransitButton?.layer.cornerRadius = 7.0
    }
    
    func addChildVC(childVC: UIViewController){
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.frame
        childVC.didMove(toParent: self)
//        childVC.didMove
    }
}

