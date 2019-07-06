//
//  DataModel.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 02/07/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import Foundation

protocol DataModelDelegateProtocol{
    func recievedDataSuccesfully(articleData:[NewsArtizxcle])
    func failedRecievingData(withError error: Error)
}

class DataModel:NSObject{
    
    static var sharedInstance = DataModel(withAPIKey: "f1302092afc14ebe95c72a4f74affa92")
    
    var delegate:DataModelDelegateProtocol?
    
    private let apiManager : NewsAPIManager?
    
    private (set) var topHeadlinesData : [NewsArtizxcle]?
    private (set) var newsCategoryData : [NewsArtizxcle]?
    
    private init(withAPIKey key: String) {
        self.apiManager = NewsAPIManager(apiKey: key)
    }
    
    func getNewsData(fromSources sources : [NewsSources]){
        weak var weakSelf = self
        apiManager!.fetchTopNewsArticles(fromSources: sources, completionHandler: { (newsArticles) in
            weakSelf?.topHeadlinesData = newsArticles
           
            if let data = (weakSelf?.topHeadlinesData!){
                weakSelf?.delegate?.recievedDataSuccesfully(articleData: data)
            }
            
        })
        { (error) in
            weakSelf?.delegate?.failedRecievingData(withError: error)
        }
    }
    
    func getNewsData(fromCategories categories : [Categories]){
        apiManager!.fetchTopNewsArticles(fromCategories: categories, completionHandler: { (newsArticles) in
            self.newsCategoryData = newsArticles
            self.delegate?.recievedDataSuccesfully(articleData: self.newsCategoryData!)
        })
        { (error) in
            self.delegate?.failedRecievingData(withError: error)
        }
    }
}
