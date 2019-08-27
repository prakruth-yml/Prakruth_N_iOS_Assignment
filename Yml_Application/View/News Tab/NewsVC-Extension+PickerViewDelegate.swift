//
//  NewsVC-Extension+PickerViewDelegate.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(viewModel.newsTypes[row])
        let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewsDisplayVC.self))
        self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.newsTypes[row]
    }
}
