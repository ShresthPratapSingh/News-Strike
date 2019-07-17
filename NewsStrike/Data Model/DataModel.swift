//
//  DataModel.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 02/07/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import Foundation

protocol DataModelDelegateProtocol{
    func recievedDataSuccesfully(articleData:[NewsArticle])
    func failedRecievingData(dueTo error: Error)
}


class DataModel:NSObject{
    
    var sourceDataHasChanged:Bool = false
    
    private override init() {
        super.init()
        if sourceData == nil {
            getSourceData()
        }
    }
    
    static var sharedInstance = DataModel()
    
    var delegate:DataModelDelegateProtocol?
    
    private let apiManager = NewsAPIManager(apiKey: "f1302092afc14ebe95c72a4f74affa92")
    
    private (set) var topHeadlinesData : [NewsArticle]?
    private (set) var newsCategoryData : [NewsArticle]?
    
    private(set) var sourceData:[NewsSource]?{
        didSet{
            sourceDataHasChanged = true
            for source in sourceData!{
                if let name = source.sourceName{
                    SettingsDataModel.data[1].append(name)
                }
            }
            SettingsDataModel.delegate?.dataUpdatedSuccesfully()
        }
    }
    
    func getSourceData(){
        apiManager.fetchNewsSources(completionHandler: { (sources) in
            self.sourceData = sources
        }, failure: {(error) in})
    }
    
    func getSelectedSources()->[NewsSource]{
        var selectedSourceArray = [NewsSource]()
        if sourceData != nil{
            for source in sourceData!{
                if source.isSelected{
                    selectedSourceArray.append(source)
                }
            }
        }
        return selectedSourceArray
    }
    
    func getNewsData(fromSources sources : [NewsSource]){
        weak var weakSelf = self
        apiManager.fetchTopNewsArticles(fromSources: sources, completionHandler: { (newsArticles) in
            weakSelf?.topHeadlinesData = newsArticles
           
            if let data = (weakSelf?.topHeadlinesData!){
                weakSelf?.delegate?.recievedDataSuccesfully(articleData: data)
            }
            
        })
        { (error) in
            weakSelf?.delegate?.failedRecievingData(dueTo: error)
        }
    }
    
    func getNewsData(fromCategories categories : [Categories]){
        apiManager.fetchTopNewsArticles(fromCategories: categories, completionHandler: { (newsArticles) in
            self.newsCategoryData = newsArticles
            self.delegate?.recievedDataSuccesfully(articleData: self.newsCategoryData!)
        })
        { (error) in
            self.delegate?.failedRecievingData(dueTo: error)
        }
    }
    
    
}
