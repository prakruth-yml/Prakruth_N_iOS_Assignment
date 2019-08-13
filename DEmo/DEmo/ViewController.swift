//
//  ViewController.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 08/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class KVOObjectClass: NSObject{
    
    @objc var textInt: String = ""
}

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var storyTransitButton: UIButton!
    @IBOutlet weak var codeTransitButton: UIButton!

    @IBOutlet var name: UIView!
    
    @objc var obj = KVOObjectClass()
    //var observerObj: NSKeyValueObservation
    
    @objc var textFieldInput: String? = ""
           
    let containerView = UIView()
    var storyBoardVC = StroyBoardVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpUI()
        
        codeTransitButton.addTarget(self, action: #selector(codeTransitButtonDidPress), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.isAlphabetsOnly), name: UITextField.textDidEndEditingNotification, object: nil)
        
        obj.textInt = "bibc"
        print(obj.textInt)
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        print("in KVO")
//        if keyPath == #keyPath(obj.textInt){
//            print("Did Change")
//        }
//    }

    @IBAction func storyTransitButtonDidPress(buttonElement: UIButton){
        
        print("Button Pressed \(buttonElement.currentTitle ?? "nil")")
    }
    
    func isAlphabetOnly2() -> Bool{
        if let str = nameTextField?.text{
            print(str)
            let range = NSRange(location: 0, length: str.count)
            let regex = try! NSRegularExpression(pattern: "[0-9]+")
            if(regex.firstMatch(in: str, options: [], range: range)) != nil{
                return false
            }
            else{
                return true
            }
        }
        return false
    }
    
    //@objc func isAlphabetOnly()
    func textFieldDidEndEditing(_ nameTextField: UITextField) {
        
        print("Done Editting")
        if(isAlphabetOnly2()){
            self.codeTransitButtonDidPress(buttonElement: codeTransitButton)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "Please Enter only Letters", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default, handler: nil)
            alert.addAction(action)
            _ = textFieldShouldClear(nameTextField)
            present(alert, animated: true, completion: nil)
        }
    }
    
   // @IBAction func codeTransitButtonDidPress(buttonElement: UIButton){
    @objc func codeTransitButtonDidPress(buttonElement: UIButton){

        print("Button Pressed \(buttonElement.currentTitle ?? "nil") \(nameTextField.text ?? "nil")")
        let secondVC = ProgramV_C()
        textFieldInput = self.nameTextField.text
        secondVC.nameFromVC = self.nameTextField.text
        
        if(self.isAlphabetOnly2()){
            self.present(secondVC, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "Please Enter only Letters", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default, handler: nil)
            alert.addAction(action)
            nameTextField?.text = ""
            present(alert, animated: true, completion: nil)
        }

    }

    
    
    func setUpUI(){
        
        titleLabel?.layer.cornerRadius = 5.0
        logoImage?.layer.cornerRadius = 7.0
        storyTransitButton?.layer.cornerRadius = 7.0
        codeTransitButton?.layer.cornerRadius = 7.0
        titleLabel.center.x = UIScreen.main.bounds.width/2
        logoImage.center.x = UIScreen.main.bounds.width/2
        logoTitleLabel.center.x = UIScreen.main.bounds.width/2
        nameTextField.center.x = UIScreen.main.bounds.width/2
        storyTransitButton.center.x = UIScreen.main.bounds.width/2 - 100
        codeTransitButton.center.x = UIScreen.main.bounds.width/2 + 100

        
        
        self.nameTextField.delegate = self
        
        addObserver(self, forKeyPath: #keyPath(obj.textInt), options: [.old, .new], context: nil)
        
        obj.textInt = "bibc"
        print(obj.textInt)
        
        //CXheck it
//        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyBoardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyBoardWillHide, object: nil)
    }
    
    @objc func applicationWillResignActive(){
        print("In Notifiaction")
//        let storyBoardVC = StroyBoardVC()
//        storyBoardVC.text = "Changed"
//        print(storyBoardVC.text)
//        print(storyBoardVC.goBackButton.buttonType)
//        print(storyBoardVC.colorChangeView.alpha)
//        storyBoardVC.colorChangeView.backgroundColor = UIColor.red
//        storyBoardVC.changeViewColor(object: storyBoardVC)
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        print("In  Keyboiard")
        return true
    }

    func textFieldShouldClear(_ nameTextField: UITextField) -> Bool {
        nameTextField.text = ""
        return true
    }
    
//    func textFieldDidEndEditing(_ nameTextField: UITextField) {
//
//        print("Done editting")
//        textFieldShouldClear(nameTextField)
//    }
}

