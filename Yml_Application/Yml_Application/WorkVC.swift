//
//  AboutUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import WebKit

class WorkVC: UIViewController{
    
    @IBOutlet weak var homePageImage: UIImageView!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var webView: WKWebView!
    var workCell: WorkVCTableViewCell?
    var url = ""
//    @IBOutlet weak var workDescriptionLabel: UILabel!
    
    var worksData: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGUI()
        worksData = getData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        print(tableView.frame.height)
        tableView.rowHeight = tableView.frame.height - 50
        let webConfigs = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfigs)
        webView.uiDelegate = self
        
//        var myNewView = UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 200))
//        myNewView.backgroundColor=UIColor.lightGray
//
//        // Add rounded corners to UIView
//        myNewView.layer.cornerRadius=25
//
//        // Add border to UIView
//        myNewView.layer.borderWidth=2
//
//        // Change UIView Border Color to Red
//        myNewView.layer.borderColor = UIColor.red.cgColor
        
        
//        let url = URL(string: "https://www.google.com")
//                let myrequest = URLRequest(url: url!)
//                webView.load(myrequest)
//                var webViewView = UIView(frame: tableView.frame)
//                webViewView.backgroundColor = .red
////                webViewView.addSubview(<#T##view: UIView##UIView#>)
////        view = webView
//                self.tableView.addSubview(webViewView)
        // Add UIView as a Subview
//        self.view.addSubview(webViewView)
        
    }
    
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        workCell = WorkVCTableViewCell()
//        print(workCell?.workDescription.text)
//
//    }
    
    func getData() -> [Data]{
        return[Data(imageName: "tnf-hero", titleText: "THE NORTH FACE", desc: "How The North Face redefined loyalty to embrace the great outdoors.", webUrl: "https://ymedialabs.com/project/the-north-face"), Data(imageName: "clover_go_photo", titleText: "CLOVER", desc: "How Clover Go has become an open ecosystem for point-of-sale payments.", webUrl: "https://ymedialabs.com/project/clover"), Data(imageName: "hero-still-featured", titleText: "C3.AI", desc: "How this new website helped C3.ai make enterprise AI simple.", webUrl: "https://ymedialabs.com/project/c3")]
    }
    
    @objc func didPressLabel(_ sender: UITapGestureRecognizer){
        
//        let url = URL(string: self.url)
//        let myrequest = URLRequest(url: url!)
//        webView.load(myrequest)
//        var webViewView = UIView(frame: tableView.frame)
//        webViewView.backgroundColor = .red
//        webViewView = webView
//        self.tableView.addSubview(webViewView)
//        view = webView
        
        
        let viewController: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewVC2") as! UINavigationController
        self.present(viewController, animated: false, completion: nil)
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
        let webUrl: String
        
        init(imageName: String, titleText: String, desc: String, webUrl: String){
            self.imageName = imageName
            self.titleText = titleText
            self.description = desc
            self.webUrl = webUrl
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as? WorkVCTableViewCell
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressLabel(_:)))
        url = worksData[indexPath.row].webUrl
        cell?.workDescription.addGestureRecognizer(cellTapGesture)
    }
    
    //CLARIFY
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print("dcabskdc")
    }
}

extension WorkVC: WKUIDelegate{
    
}
