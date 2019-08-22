//
//  AboutUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WorkVC: UIViewController{
    
    @IBOutlet weak var homePageImage: UIImageView!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var worksData: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGUI()
        worksData = getData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getData() -> [Data]{
        return[Data(imageName: "tnf-hero", titleText: "THE NORTH FACE", desc: "How The North Face redefined loyalty to embrace the great outdoors."), Data(imageName: "clover_go_photo", titleText: "CLOVER", desc: "How Clover Go has become an open ecosystem for point-of-sale payments."), Data(imageName: "hero-still-featured", titleText: "C3.AI", desc: "How this new website helped C3.ai make enterprise AI simple.")]
    }
    
    func setupGUI(){

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

extension WorkVC{
    struct Data{
        
        let imageName: String
        let titleText: String
        let description: String
        
        init(imageName: String, titleText: String, desc: String){
            self.imageName = imageName
            self.titleText = titleText
            self.description = desc
        }
    }
}

extension WorkVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worksData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkVCTableViewCell.self), for: indexPath) as? WorkVCTableViewCell
        cell?.workImage.image = UIImage(named: worksData[indexPath.row].imageName)
        cell?.workTitle.text = worksData[indexPath.row].titleText
        cell?.workDescription.text = worksData[indexPath.row].description
        return cell ?? UITableViewCell()
    }
}
