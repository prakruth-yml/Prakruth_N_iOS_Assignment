//
//  WebServicesAssignment.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 16/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WebServicesAssignment: UIViewController {

    
    @IBOutlet weak var  titleLabel: UILabel!
    @IBOutlet weak var  titleField: UITextField!
    
    var wordToSearch: String = ""
    let urlString = "https://od-api.oxforddictionaries.com/api/v2"
    let appID = "701c9c97"
    let appKey = "ab5b061ec5a81e1e172b828302ee964e"
    let lang = "en-us"
    let field = "definitions"
    let strictMatch = "false"
    var urlDataTask: URLSessionDataTask?
    var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        wordToSearch = titleField?.text ?? "nil"
        networkingSetup()
    }
    
    func networkingSetup(){
        
//        wordToSearch = titleField.text?.lowercased() ?? "nil"
        wordToSearch = "hello"
        let urlStr = "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(lang)/\(wordToSearch)?fields=\(field)&strictMatch=\(strictMatch)"
        let url = URL(string: urlStr)
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(appID, forHTTPHeaderField: "app_id")
        urlRequest.addValue(appKey, forHTTPHeaderField: "app_key")

        urlDataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

            if let errorInCloure = error{
                print(errorInCloure as Any)
            }
            else{
                self.callApi(data: data!, response: response!)
            }
        })
        
        urlDataTask?.resume()
    }
    
    func callApi(data: Data?, response: URLResponse){
        
        if let dataItems = data{
            do{
//                let jsonReturn = try JSONSerialization.jsonObject(with: dataItems, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [AnyObject]
                let jsonReturn = try JSONSerialization.jsonObject(with: dataItems, options: JSONSerialization.ReadingOptions(rawValue: 0))
                print(response)
                print(jsonReturn)
                print("\(type(of: jsonReturn))")
                
            }catch{
                print("Exception Caught")
            }
        }
        else{
            
        }
    }
    
    func setupUI(){
        
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
