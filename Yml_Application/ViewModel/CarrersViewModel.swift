//
//  CarrersViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
class CarrersViewModel{
    
    var jsonResponse: [Data] = []
    
    func getData() {
        let urlStr = "http://jsonstub.com/positions"
        guard let url = URL(string: urlStr) else { fatalError() }
        var request = URLRequest(url: url)
        let userKey = "5b87065d-b207-44fc-aa26-b9e1253720d6"
        let projectKey = "9a5070e8-cd53-46d4-ae0a-c25f3458c81c"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(userKey, forHTTPHeaderField: "JsonStub-User-Key")
        request.addValue(projectKey, forHTTPHeaderField: "JsonStub-Project-Key")
        
        let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error{
                print(error)
            }
            if let response = response, let data = data{
                let mainData = try? JSONDecoder().decode(ResponseFromJSON.self, from: data)
                print(mainData)
//                let data = mainData?.data
//                self.jsonReturnData = data!
//                DispatchQueue.main.sync {
//                    tableView.reloadData()
//                }
            }
        })
        session.resume()
    }
}
