//
//  WorkVC-Extension+TableViewDataSource.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension WorkVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.workData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkVCTableViewCell.self), for: indexPath) as? WorkVCTableViewCell
        cell?.workImage.image = UIImage(named: viewModel.workData[indexPath.row].imageName)
        cell?.workTitle.text = viewModel.workData[indexPath.row].titleText
        cell?.workDescription.text = viewModel.workData[indexPath.row].description
        return cell ?? UITableViewCell()
    }
}
