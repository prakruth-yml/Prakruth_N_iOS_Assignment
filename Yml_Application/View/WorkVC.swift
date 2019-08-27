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
    
    var viewModel = WorkViewModel()
    
//    var workModel = WorkModel()
    var webView: WKWebView!
    var workCell: WorkVCTableViewCell?
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        
        //DOUBT
//        print(viewModel.workData[0].titleText)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .black
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//        tableView.rowHeight = tableView.frame.height - 50
    }
    
    //DOUBT
    @objc func didPressLabel(_ sender: UITapGestureRecognizer){
 
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewVC4.self)) as? WebViewVC4 else{fatalError()}
        viewController.urlStr = url
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
