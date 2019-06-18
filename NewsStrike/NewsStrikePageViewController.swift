//
//  NewsStrikePageViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 17/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit
import NewsAPISwift

class NewsStrikePageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.askProviderForNews()
        }
        let loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loadingViewController") 
        setViewControllers([loadingVC], direction: .forward, animated: true, completion: nil)
    }
    
     private var sourceString = ["abc-news","cnn","business-insider","cbs-news","cnbc","daily-mail","crypto-coins-news","fortune","fox-news","google-news","national-geographic","nbc-news","techcrunch-cn","techcrunch","techradar","the-new-york-times","time","the-times-of-india","the-economist","google-news-in"]
    
    private var headlines = [NewsArticle]()
   
    private var currentIndextInDataModel : Int = 0
    
    func askProviderForNews(){
        let newsAPI = NewsAPI(apiKey: "f1302092afc14ebe95c72a4f74affa92")
        newsAPI.getTopHeadlines(q: "", sources: sourceString, category: .all, language: .en, country: .all){
            result in
            switch result{
            case .failure(let error):
                print(error)
                break
            case .success(let headlines):
                self.headlines = headlines
                
                DispatchQueue.main.async {
                    self.setViewControllers([self.getViewControllerFor(index: 0)], direction: .forward, animated: true, completion: nil)
                }
                
                break
            }
        }
    }
    
    func getViewControllerFor(index currentIndex: Int) -> NewsViewController{
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        viewController.setVCPropertiesFor(url: headlines[currentIndex].urlToImage, headline: headlines[currentIndex].title, article: headlines[currentIndex].articleDescription ?? "Article Description not provided by provider")
        return viewController
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndextInDataModel < headlines.count else{return nil}
        if currentIndextInDataModel != 0{
            guard currentIndextInDataModel-1 >= 0 else{return nil}
            currentIndextInDataModel -= 1
            return getViewControllerFor(index: currentIndextInDataModel)
        }
        else {return nil}
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard  currentIndextInDataModel+1 < headlines.count else {return nil}
        currentIndextInDataModel += 1
        return getViewControllerFor(index: currentIndextInDataModel)
    }
    
}

