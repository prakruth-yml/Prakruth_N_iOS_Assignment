//
//  WebServicesAssignment.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 16/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class WebServicesAssignment: UIViewController, UITextFieldDelegate {

    
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
    var meaning : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleField.delegate = self
        setupUI()
        //networkingSetup()
    }
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        wordToSearch = self.titleField?.text?.lowercased() ?? "nil"
        networkingSetup()
        print("done")
        
//        var tvc = OxfordResultsTableVC()
//        tvc.meanings = meaning
//        tvc.viewDidLoad()
        //self.navigationController?.pushViewController(tvc, animated: true)
        
//        let tvc = storyboard?.instantiateViewController(withIdentifier: "OxfordResultsTableVC") as? OxfordResultsTableVC
//        self.navigationController?.pushViewController(tvc!, animated: true)
        
        return true
    }
    

    
    func networkingSetup(){

        let urlStr = "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(lang)/\(self.wordToSearch)?fields=\(field)&strictMatch=\(strictMatch)"
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
                let jsonReturn = try JSONSerialization.jsonObject(with: dataItems, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! NSDictionary
                let temp = jsonReturn["results"] as! NSArray
                let temp2 = temp[0] as! NSDictionary
                let temp3 = temp2["lexicalEntries"] as? NSArray
                let temp4 = temp3?[0] as? NSDictionary
                let temp5 = temp4?["entries"] as? NSArray
                let temp6 = temp5?[0] as? NSDictionary
                let temp7 = temp6?["senses"] as? NSArray
                let temp8 = temp7?[0] as? NSDictionary
                let temp9 = temp8?["definitions"]
                let temppp = temp9 as? NSArray
                let temp1111 = temppp![0] as? String
                meaning.append(temp1111 ?? "nil")
                let temp10 = temp8?["subsenses"] as? NSArray

                for item in temp10!{
                    let tempp = item as? NSDictionary
                    let x = tempp?["definitions"] as? NSArray
                    let xx = x![0] as? String
                    meaning.append(xx ?? "nil")
                }

                print("done 2")


            }catch{
                print("Exception Caught")
            }
        }
        else{

        }
    }
    
    func setupUI(){
        
    }

}
