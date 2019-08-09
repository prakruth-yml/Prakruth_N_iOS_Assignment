//
//  ProgramV_C.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 09/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ProgramV_C: UIViewController {
    
    var nameLabel: UILabel!
    var backButton: UIButton!
    var nameFromVC: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        let labelCoords = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 180, height: 21)
        nameLabel = UILabel(frame: labelCoords)
        nameLabel?.center.x = UIScreen.main.bounds.width/2
//        nameLabel?.text = "Name will appear here"
        self.view.addSubview(nameLabel)
        
        let buttonCoords = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2+20, width: 180, height: 21)
        //        let buttonCoords = CGRect(x: 15, y: 50, width: 300, height: 50)
        backButton = UIButton()
        backButton.frame = buttonCoords
        backButton.backgroundColor = UIColor.black
        backButton?.center.x = UIScreen.main.bounds.width/2
        backButton?.setTitle("Back", for: .normal)
        backButton?.addTarget(self, action: #selector(self.didPressBackButton), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        if let text = self.nameFromVC{
            print(text)
            nameLabel?.text = text
        }
        else{
            print("NIL")
        }
        print()
    }
    
    @objc func didPressBackButton(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
