//
//  NewsViewModel.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 27/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import Foundation

class NewsViewModel{
    
//    var NewsDataModel.newsTypes = ["Select Option", "Design", "FinTech"]
    var newsTypes: [String] = []
    var dataToDisplay: [NewsDataModel.NewsData] = []
    
    //Design DataSource Function for cell
    func getDesignData() {
        dataToDisplay =  [NewsDataModel.NewsData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/07/mcdonalds-lead.jpeg", titleText: "Agency / Culture / Design / Leadership / Technology", descriptionTextL: "We Are People: What it Means to Have a People-First Approach", urlStr: "https://ymedialabs.com/project/the-north-face"), NewsDataModel.NewsData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/05/earnin-rect.png", titleText: "Design / Technology", descriptionTextL: "Speaking the Same Language: How UX and Data Strategy Can Work Together to Design for Voice-Based AI", urlStr: "http://www.ymedialabs.com/getting-to-know-hamish-macphail-chief-financial-officer-at-y-media-labs"), NewsDataModel.NewsData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/06/design-mocks.png", titleText: "Customer Experience / Design / Technology", descriptionTextL: "Don’t Overthink It: Design is a Tool For Making Businesses Better", urlStr: "http://www.ymedialabs.com/voice-based-ai")]
    }
    
    //FinTech DataSource Function for cell
    func getFinTechData() {
        dataToDisplay =  [NewsDataModel.NewsData(imageName: "https://ymedialabs.com/wp-content/uploads/2019/05/earnin-rect.png", titleText: "Customer Experience / Fintech / Technology / Trending", descriptionTextL: "YML Partners With FinTech App, Earnin, on Customer Experience Development Work", urlStr: "http://www.ymedialabs.com/b2b-b2c-applications-iot-banking"), NewsDataModel.NewsData(imageName: "https://ymedialabs.com/wp-content/uploads/2018/05/pexels-photo-905869.jpeg", titleText: "FinTech", descriptionTextL: "B2B and B2C Applications for IoT in Banking", urlStr: "http://www.ymedialabs.com/crypto-chaos%e2%80%8a")]
    }
    
    func setNewsTypes(){
        newsTypes = ["Select Option", "Design", "FinTech"]
    }
}
