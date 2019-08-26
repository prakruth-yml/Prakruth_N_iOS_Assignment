//
//  NewsDisplayVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 23/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class NewsDisplayVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var data: [DesignData] = []
    var urlStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .gray
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        data = getDesignData()
    }
    
    
    //Design DataSource Function for cell
    func getDesignData() -> [DesignData]{
        return [DesignData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/07/mcdonalds-lead.jpeg", titleText: "Agency / Culture / Design / Leadership / Technology", descriptionTextL: "We Are People: What it Means to Have a People-First Approach", urlStr: "https://ymedialabs.com/project/the-north-face"), DesignData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/05/earnin-rect.png", titleText: "Design / Technology", descriptionTextL: "Speaking the Same Language: How UX and Data Strategy Can Work Together to Design for Voice-Based AI", urlStr: "http://www.ymedialabs.com/getting-to-know-hamish-macphail-chief-financial-officer-at-y-media-labs"), DesignData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/06/design-mocks.png", titleText: "Customer Experience / Design / Technology", descriptionTextL: "Don’t Overthink It: Design is a Tool For Making Businesses Better", urlStr: "http://www.ymedialabs.com/voice-based-ai")]
    }
    
    //FinTech DataSource Function for cell
    func getFinTechData() -> [DesignData]{
        return [DesignData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/05/earnin-rect.png", titleText: "Customer Experience / Fintech / Technology / Trending", descriptionTextL: "YML Partners With FinTech App, Earnin, on Customer Experience Development Work", urlStr: "http://www.ymedialabs.com/b2b-b2c-applications-iot-banking"), DesignData(imageName: "https://ymedialabs.com/wp-content/uploads/2018/05/pexels-photo-905869.jpeg", titleText: "FinTech", descriptionTextL: "B2B and B2C Applications for IoT in Banking", urlStr: "http://www.ymedialabs.com/crypto-chaos%e2%80%8a")]
    }
    
    //Action function to capture segment change
    @IBAction func segmentIndexChanged(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
            case 0:
                data = getDesignData()
            case 1:
                data = getFinTechData()
            default:
                print("")
        }
        tableView.reloadData()
    }
    
    @objc func didPressLabel(_ sender: UITapGestureRecognizer){
        print("csdavas")
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewVC4.self)) as? WebViewVC4 else{fatalError()}
        viewController.urlStr = urlStr
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NewsDisplayVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = .green
        print(data[indexPath.row].titleText)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDisplayTableViewCell.self), for: indexPath) as? NewsDisplayTableViewCell
        let urlTemp = URL(string: data[indexPath.row].imageName)
        cell?.newImageView.loadImageFromURL(url: urlTemp!)
        cell?.titleText.text = data[indexPath.row].titleText
        cell?.descriptionText.text = data[indexPath.row].descriptionTextL
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDisplayTableViewCell.self), for: indexPath) as? NewsDisplayTableViewCell
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressLabel(_:)))
        urlStr = data[indexPath.row].urlStr
        cell?.descriptionText.addGestureRecognizer(cellTapGesture)
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewVC4.self)) as? WebViewVC4 else{fatalError()}
        viewController.urlStr = urlStr
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct DesignData {
    let imageName: String
    let titleText: String
    let descriptionTextL: String
    let urlStr: String
}
