//
//  NewsDisplayVC-Extension+TableViewDelegate.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension NewsDisplayVC: UITableViewDelegate{
    
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
