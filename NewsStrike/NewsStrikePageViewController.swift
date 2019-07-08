//
//  NewsStrikePageViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 17/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsStrikePageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        DataModel.sharedInstance.delegate = self
        
        let loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loadingViewController") 
        setViewControllers([loadingVC], direction: .forward, animated: true, completion: nil)
        self.askProviderForNews()
    }
    
    private var sourceArray : [NewsSources]?
    var category : Categories = .all
    
      private var sources : [NewsSources] = [.abcNews,.cnn,.buisnessInsider,.cbsNews,.cnbc,.dailyMail,.cryptoCoinsNews,.fortune,.foxNews,.googleNews,.natGeo,.nbcNews,.techcrunch,.techradar,.theNewYorkTimes,.time,.theTimesOfIndia,.theEconomist,.googleNewsIndia]
    
    private var headlinesData = [NewsArtizxcle](){
        didSet{
            setViewControllers([getViewControllerFor(index: currentIndextInDataModel)], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private var currentIndextInDataModel : Int = 0
    
    private var dataModelInstance = DataModel.sharedInstance
    
    func askProviderForNews(){
        if category == Categories.all{
            if dataModelInstance.topHeadlinesData != nil{
                headlinesData = dataModelInstance.topHeadlinesData!
            }else{
                dataModelInstance.getNewsData(fromSources: sources)
            }
        }else{
            dataModelInstance.getNewsData(fromCategories: [category])
        }
        
    }
    
    func getViewControllerFor(index currentIndex: Int) -> NewsArticleViewController{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsArticleViewController") as! NewsArticleViewController
        if let url = headlinesData[currentIndex].articleImageURL,let articleURL = headlinesData[currentIndex].articleURL{
            viewController.setVCPropertiesFor(urlToImage: url ,urlToArticle:articleURL, headline: headlinesData[currentIndex].articleTitle ?? "Title not available", article: headlinesData[currentIndex].articleDescription ?? "Article Description not available")
        }
        
        return viewController
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndextInDataModel < headlinesData.count else{return nil}
        if currentIndextInDataModel >= 0{
            guard currentIndextInDataModel-1 >= 0 else{return nil}
            currentIndextInDataModel -= 1
            return getViewControllerFor(index: currentIndextInDataModel)
        }
        else {return nil}
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard  currentIndextInDataModel+1 < headlinesData.count else {return nil}
        currentIndextInDataModel += 1
        return getViewControllerFor(index: currentIndextInDataModel)
    }
    
}

extension NewsStrikePageViewController: DataModelDelegateProtocol{
    func recievedDataSuccesfully(articleData: [NewsArtizxcle]) {
        self.headlinesData = articleData
    }
    
    func failedRecievingData(withError error: Error) {
        
    }
}
