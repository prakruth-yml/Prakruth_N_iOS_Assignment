//
//  NewsDisplayVC-Extension+TableViewDataSource.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension NewsDisplayVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.dataToDisplay.count)
        return viewModel.dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = .green
        print(viewModel.dataToDisplay[indexPath.row].titleText)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDisplayTableViewCell.self), for: indexPath) as? NewsDisplayTableViewCell
        let urlTemp = URL(string: viewModel.dataToDisplay[indexPath.row].imageName)
        cell?.newImageView.loadImageFromURL(url: urlTemp!)
        cell?.titleText.text = viewModel.dataToDisplay[indexPath.row].titleText
        cell?.descriptionText.text = viewModel.dataToDisplay[indexPath.row].descriptionTextL
        return cell ?? UITableViewCell()
    }
}
