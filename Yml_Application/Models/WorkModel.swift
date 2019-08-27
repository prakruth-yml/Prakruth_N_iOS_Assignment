//
//  WorkModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
struct WorkTableViewData{
        
    let imageName: String
    let titleText: String
    let description: String
    let webUrl: String
        
    init(imageName: String, titleText: String, desc: String, webUrl: String){
        self.imageName = imageName
        self.titleText = titleText
        self.description = desc
        self.webUrl = webUrl
    }
}
