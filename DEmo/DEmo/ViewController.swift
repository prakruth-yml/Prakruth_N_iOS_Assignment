//
//  ViewController.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 08/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

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
        
        print("Button Pressed \(buttonElement.currentTitle ?? "nil") \(nameTextField.text)")
        let secondVC = ProgramV_C()
        secondVC.nameFromVC = self.nameTextField.text
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
    
    func setUpUI(){
        
        titleLabel?.layer.cornerRadius = 5.0
        logoImage?.layer.cornerRadius = 7.0
        storyTransitButton?.layer.cornerRadius = 7.0
        codeTransitButton?.layer.cornerRadius = 7.0
        
        self.nameTextField.delegate = self
        
        //CXheck it
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyBoardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyBoardWillHide, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
}

