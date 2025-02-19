//
//  NewsVC.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 21/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class NewsVC: BaseVC {
    
    @IBOutlet weak var pickerView: UIPickerView!
    var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setNewsTypes()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        print("News Loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("News Appeared")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("News Disappeared")
    }

}

extension NewsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.newsTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(viewModel.newsTypes[row])
        let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewsDisplayVC.self))
        self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.newsTypes[row]
    }
}

