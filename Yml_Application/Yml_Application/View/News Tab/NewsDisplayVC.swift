//
//  NewsDisplayVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 23/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class NewsDisplayVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var viewModel = NewsViewModel()
    var urlStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .black
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        viewModel.getDesignData()
    }
  
    //Action function to capture segment change
    @IBAction func segmentIndexChanged(sender: UISegmentedControl){
        
        viewModel.changeSegment(segmentIndex: sender.selectedSegmentIndex)
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
        print(viewModel.dataToDisplay.count)
        return viewModel.dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(viewModel.dataToDisplay[indexPath.row].titleText)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDisplayTableViewCell.self), for: indexPath) as? NewsDisplayTableViewCell
        guard let urlTemp = URL(string: viewModel.dataToDisplay[indexPath.row].imageName) else { fatalError() }
        cell?.newImageView.loadImageFromURL(url: urlTemp)
        cell?.titleText.text = viewModel.dataToDisplay[indexPath.row].titleText
        cell?.descriptionText.text = viewModel.dataToDisplay[indexPath.row].descriptionTextL
        print(tableView.rowHeight)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDisplayTableViewCell.self), for: indexPath) as? NewsDisplayTableViewCell
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didPressLabel(_:)))
        urlStr = viewModel.dataToDisplay[indexPath.row].urlStr
        cell?.descriptionText.addGestureRecognizer(cellTapGesture)
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebViewVC4.self)) as? WebViewVC4 else{fatalError()}
        viewController.urlStr = urlStr
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
