//
//  NewsAPIManager.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 29/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import Alamofire

enum Language : String {
    case english = "en"
}

enum Categories : String{
    case all = ""
    case sports
    case business
    case entertainment
    case science
    case technology
    case health
    case general
}

enum Country : String{
    case all = ""
}



enum NewsSources : String,CaseIterable{
    case abcNews = "abc-news"
    case cnn = "cnn"
    case buisnessInsider = "business-insider"
    case cbsNews = "cbs-news"
    case cnbc = "cnbc"
    case dailyMail = "daily-mail"
    case cryptoCoinsNews = "crypto-coins-news"
    case fortune = "fortune"
    case foxNews = "fox-news"
    case googleNews = "google-news"
    case natGeo = "national-geographic"
    case nbcNews = "nbc-news"
    case techcrunch = "techcrunch"
    case techradar = "techradar"
    case theNewYorkTimes = "the-new-york-times"
    case time = "time"
    case theTimesOfIndia = "the-times-of-india"
    case theEconomist = "the-economist"
    case googleNewsIndia = "google-news-in"
}

class NewsAPIManager: NSObject {
    private let apiKey:String
    
    init(apiKey:String) {
        self.apiKey = apiKey
    }
    
    func fetchTopNewsArticles(fromCategories categories : [Categories],inLanguage language:Language = .english,completionHandler: @escaping ([NewsArticle])->Void,failure: (@escaping (Error)->())){
        var urlString = "https://newsapi.org/v2/sources?"
        let categoryString = generateCategoryString(from: categories)
        urlString.append(categoryString  + "&language=\(language.rawValue)" + "&apiKey=\(apiKey)")
        
        
        if let url = URL(string: urlString){
            Alamofire.request(url).validate().responseJSON { (response) in
                switch(response.result){
                case .failure(let error):
                    if let failureResponseValue = response.result.value as? [String:String]{
                        print("\n\n!!!!!!ERROR!!!!!!\n\n\(String(describing: failureResponseValue["code"]))\n\(String(describing: failureResponseValue["message"]))")
                        failure(error)
                    }
                default:
                    if let jsonResponse = response.result.value as? [String:Any?],let sourcesArray = jsonResponse["sources"] as? [[String:String?]]{
                        var sourceString = String()
                        for sourceDict in sourcesArray{
                            if let sourceID = sourceDict["id"]{
                                if sourceDict == sourcesArray.last{
                                    sourceString.append(sourceID!)
                                }else{
                                    sourceString.append(sourceID! + ",")
                                }
                            }
                        }
                        if let newURL = URL(string: "https://newsapi.org/v2/everything?sources="+sourceString+"&apiKey=\(self.apiKey)"){
                            Alamofire.request(newURL).validate().responseJSON(completionHandler: { (response) in
                                switch (response.result){
                                case .failure(let error):
                                    if let failureResponseValue = response.result.value as? [String:String]{
                                        print("\n\n!!!!!!ERROR!!!!!!\n\n\(String(describing: failureResponseValue["code"]))\n\(String(describing: failureResponseValue["message"]))")
                                    }
                                    failure(error)
                                default:
                                    if let jsonResponse = response.result.value as? [String: Any?], let articlesDict = jsonResponse["articles"] as? [[String: Any?]] {
                                        var newsArticles = [NewsArticle]()
                                        for article in articlesDict {
                                            newsArticles.append(NewsArticle(article))
                                        }
                                        completionHandler(newsArticles)
                                    }
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func fetchTopNewsArticles(fromSources sources: [NewsSource],inLanguage language:Language = .english, completionHandler: @escaping (([NewsArticle]) -> ()), failure: @escaping (Error) -> Void) {
        var urlString = "https://newsapi.org/v2/top-headlines?"
        let sourceString = generateSourceString(from: sources)
        urlString.append(sourceString + "&language=\(language.rawValue)" + "&apiKey=\(apiKey)")
        
        if let url = URL(string: urlString){
            Alamofire.request(url).validate().responseJSON { (response) in
                switch (response.result){
                case .failure(let error):
                    if let failureResponseValue = response.result.value as? [String:String]{
                        print("\n\n!!!!!!ERROR!!!!!!\n\n\(String(describing: failureResponseValue["code"]))\n\(String(describing: failureResponseValue["message"]))")
                    }
                    failure(error)
                default:
                    if let jsonResponse = response.result.value as? [String: Any?], let articlesDict = jsonResponse["articles"] as? [[String: Any?]] {
                            var newsArticles = [NewsArticle]()
                            for article in articlesDict {
                                newsArticles.append(NewsArticle(article))
                            }
                            completionHandler(newsArticles)
                        }
                    }
                }
            }
    }
    
    func fetchNewsSources(for category: Categories = .all,_ language:Language = .english,_ country : Country = .all,completionHandler:@escaping ([NewsSource])->(),failure:@escaping (Error)->()){
        var urlString = "https://newsapi.org/v2/sources?"
        urlString.append("category=\(category.rawValue)&"+"language=\(language.rawValue)&"+"country=\(country.rawValue)&"+"apiKey=\(apiKey)")
        if let url = URL(string: urlString){
            Alamofire.request(url).validate().responseJSON { (response) in
                switch response.result{
                case .failure(let error):
                    print("!!Failed to fetch sources!!")
                    failure(error)
                default:
                    if let jsonResponse = response.result.value as? [String:Any?],let sourcesJSON = jsonResponse["sources"] as? [[String:String?]]{
                        var newsSources = [NewsSource]()
                        for source in sourcesJSON{
                            newsSources.append(NewsSource(source))
                        }
                        completionHandler(newsSources)
                    }
                }
            }
        }
        
    }
    
    
    private func generateSourceString(from sources:[NewsSource])->String{
        var sourceString = "sources="
        for source in sources{
            if source.sourceID != nil{
                if source != sources.last{
                    sourceString.append(source.sourceID! + ",")
                }else{
                    sourceString.append(source.sourceID!)
                }
            }
        }
        return sourceString
    }
    
    private func generateCategoryString(from categories: [Categories]) -> String {
        var categoryString = "category="
        let _ = categories.map{
            if $0 != categories.last{
                categoryString.append($0.rawValue + ",")
            }else{
                categoryString.append($0.rawValue)
            }
        }
        return categoryString
    }
}
