//
//  CarrersVC-Extension+TableViewDataSource.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension CarrersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.jsonResponse.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarrersTableVIewCell.self)) as? CarrersTableVIewCell {
            cell.domain.text = "New"
            cell.role.text = "ascawc"
            cell.location.text = "vasvasfbva"
            print(cell.domain.text)
            
//            cell.domain.text = viewModel.jsonResponse[indexPath.row].domain
//            cell.role.text = viewModel.jsonResponse[indexPath.row].role
//            cell.location.text = viewModel.jsonResponse[indexPath.row].location
            return cell
        }
        return UITableViewCell()
    }
}
