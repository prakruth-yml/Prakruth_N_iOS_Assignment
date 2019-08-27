//
//  NewsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setNewsTypes()
        pickerView?.delegate = self
        pickerView?.dataSource = self
    }
}
