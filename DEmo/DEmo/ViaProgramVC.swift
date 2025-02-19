
//
//  ViaProgramVC.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 08/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class ViaProgramVC: UIViewController {
    
    var nameLabel: UILabel!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        let labelCoords = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 180, height: 21)
        nameLabel = UILabel(frame: labelCoords)
        nameLabel?.center.x = UIScreen.main.bounds.width/2
        nameLabel?.text = "Name will appear here"
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
    }
    
    @objc func didPressBackButton(){
        
        self.dismiss(animated: true, completion: nil)
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
