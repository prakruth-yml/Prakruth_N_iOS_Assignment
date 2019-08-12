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
    
    var text = "Sn"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @IBAction func backButtonDidPress(button: UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }

    func setupUI(){
        
        //Function Initializations
        staticTextLabel?.layer.cornerRadius = 7.0
        staticTextLabel?.isUserInteractionEnabled = true
        colorChangeView?.layer.cornerRadius = 7.0
        staticTextLabel.center.x = UIScreen.main.bounds.width/2
        colorChangeView.center.x = UIScreen.main.bounds.width/2
        goBackButton.center.x = UIScreen.main.bounds.width/2
        
        self.colorChangeView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
        
        
        //
        let staticTextGesture = UITapGestureRecognizer(target: self, action: #selector(StroyBoardVC.didPressLabel(sender: )))
        staticTextLabel.addGestureRecognizer(staticTextGesture)
    }
    
    @objc func didPressLabel(sender: UITapGestureRecognizer){
        
//        self.colorChangeView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
        print("Label Press")
        changeViewColor()
    }
    
    func changeViewColor(){
        //        print(self.text)
        //        print(object?.text ?? "nil")
        
        print(self.colorChangeView.alpha)
        
//        if let objVar = object{
//            if objVar.colorChangeView != nil{
//                print("Color chnaged")
                self.colorChangeView.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
//            }
//            else{
//                print("In Inner else")
//            }
//            print("In If")
//        }
//        else{
//            print("NIL")
//        }
//        //        object?.colorChangeView?.backgroundColor = UIColor(red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: 1.0)
    }
    
    @objc func applicationWillResignActive(){
        print("In Notifiaction2")
//        let storyBoardVC = StroyBoardVC()
//        storyBoardVC.text = "Changed"
//        print(storyBoardVC.text)
//        print(storyBoardVC.goBackButton.buttonType)
//        print(self.colorChangeView.alpha)
//        storyBoardVC.colorChangeView.backgroundColor = UIColor.red
        self.changeViewColor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("Disappered")
    }
    

}
/*NEED TO ADD: CHANGE COLOR WHEN MOVING BETWEEN FOREGROUND AND BACKGROUND USING NOTIFICATIONS*/
