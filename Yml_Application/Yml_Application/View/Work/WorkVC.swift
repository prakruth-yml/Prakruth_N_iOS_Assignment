//
//  AboutUsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import WebKit

class WorkVC: BaseVC{
    
    @IBOutlet weak var homePageImage: UIImageView!
    @IBOutlet weak var ymlLogoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = WorkViewModel()
    
    var workCell: WorkVCTableViewCell?
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .black
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//        tableView.rowHeight = tableView.frame.height
    }

    @objc func didPressLabel(_ sender: UITapGestureRecognizer){
 
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewVC4.self)) as? WebViewVC4 else{fatalError()}
        viewController.urlStr = url
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension WorkVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.workData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkVCTableViewCell.self), for: indexPath) as? WorkVCTableViewCell
        cell?.workImage.image = UIImage(named: viewModel.workData[indexPath.row].imageName)
        cell?.workTitle.text = viewModel.workData[indexPath.row].titleText
        cell?.workDescription.text = viewModel.workData[indexPath.row].description
        print(tableView.rowHeight)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? WorkVCTableViewCell
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressLabel(_:)))
        url = viewModel.workData[indexPath.row].webUrl
        cell?.workDescription.addGestureRecognizer(cellTapGesture)
    }
    //CLARIFY
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print("dcabskdc")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

