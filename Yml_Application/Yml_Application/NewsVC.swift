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

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView?.delegate = self
        pickerView?.dataSource = self
    }
}

extension NewsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return newsTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(newsTypes[row])
        let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewsDisplayVC.self))
        self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newsTypes.count
    }
    
    
    
}
