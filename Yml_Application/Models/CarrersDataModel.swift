//
//  CarrersDataModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation

struct ResponseFromJSON: Decodable{
    let data: [CarrersData]
}

struct CarrersData: Decodable{
    let domain: String
    let role: String
    let location: String
}
