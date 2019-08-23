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
    
    let newsTypes = ["Select Option", "Design", "FinTech"]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView?.delegate = self
        pickerView?.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension NewsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        self.view.endEditing(true)
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
