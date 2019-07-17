//
//  NewsArticle.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 29/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsArticle: NSObject {
    var sourceName: String?
    var sourceID: String?
    var articleTitle: String?
    var articleDescription: String?
    var articleContent: String?
    var articleURL : URL?
    var articleImageURL : URL?
    var publishedAt : String?
    
    init(_ responseDictionary:[String:Any?]) {
        if let source = responseDictionary["source"] as? [String : Any?]{
            if let id = source["id"] as? String?{
                self.sourceID = id
            }
            if let name = source["name"] as? String?{
            self.sourceName = name
           }
        }
        if let titleResponse = responseDictionary["title"] as? String{
            self.articleTitle = titleResponse
        }
        if let descriptionResponse = responseDictionary["description"] as? String{
            self.articleDescription = descriptionResponse
        }
        if let contentResponse = responseDictionary["description"] as? String {
            self.articleContent = contentResponse
        }
        if let urlResponse = responseDictionary["url"] as? String{
            self.articleURL = URL(string: urlResponse)
        }
        if let imageURLResponse = responseDictionary["urlToImage"] as? String {
            self.articleImageURL = URL(string: imageURLResponse)
        }
        if let timeResponse = responseDictionary["publishedAt"] as? String {
            self.publishedAt = timeResponse
        }

        
    }
    
    
}
