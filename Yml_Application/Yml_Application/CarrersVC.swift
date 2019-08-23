//
//  CarrersVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class CarrersVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadImageFromURL2(url: URL(string: "https://ymedialabs.com/wp-content/uploads/2019/07/mcdonalds-lead.jpeg")!)
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

extension UIImageView{
    
    func loadImageFromURL2(url: URL) {
        if let imageData = try? Data(contentsOf: url){
            if let image = UIImage(data: imageData){
                self.image = image
            }
        }
    }
}
