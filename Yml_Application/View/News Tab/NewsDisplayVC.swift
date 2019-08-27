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
    
    var viewModel = NewsViewModel()
    var urlStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .gray
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        viewModel.getDesignData()
    }
    
    
    
    
    //Action function to capture segment change
    @IBAction func segmentIndexChanged(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
            case 0:
                viewModel.getDesignData()
            case 1:
                viewModel.getFinTechData()
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


