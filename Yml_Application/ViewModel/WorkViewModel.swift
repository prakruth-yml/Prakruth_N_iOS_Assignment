//
//  WorkViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation
class WorkViewModel {
    
    var workData: [WorkTableViewData] = []
    
    func getData() {
        workData = [WorkTableViewData(imageName: "tnf-hero", titleText: "THE NORTH FACE", desc: "How The North Face redefined loyalty to embrace the great outdoors.", webUrl: "https://ymedialabs.com/project/the-north-face"), WorkTableViewData(imageName: "clover_go_photo", titleText: "CLOVER", desc: "How Clover Go has become an open ecosystem for point-of-sale payments.", webUrl: "https://ymedialabs.com/project/clover"), WorkTableViewData(imageName: "hero-still-featured", titleText: "C3.AI", desc: "How this new website helped C3.ai make enterprise AI simple.", webUrl: "https://ymedialabs.com/project/c3")]
    }
}
