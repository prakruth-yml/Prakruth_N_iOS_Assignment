//
//  WorkVC-Extension+TableViewDelegate.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension WorkVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
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

