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
    
    private var sourceArray : [NewsSource]?
    public static var category : NewsCategory = .all
    private var headlines = [NewsArticle]()
    private var currentIndextInDataModel : Int = 0
    
    func askProviderForNews(){
        let newsAPI = NewsAPI(apiKey: "f1302092afc14ebe95c72a4f74affa92")
        newsAPI.getSources(category: NewsStrikePageViewController.category, language: .en, country: .all){result in
            switch result{
            case .success(let newsSources):
                self.sourceArray = newsSources

            case .failure(let error):
                print(error)
            }
        }
        
        var sourceString: [String]?
        
        //MARK:- BAD CODE(forced unwrap)
        
        if let maxRange = sourceArray?.count{
            for i in 0..<maxRange{
                if let source = sourceArray?[i]{
                    sourceString?.append(source.id)
                }else{
                    print("cannot parse source id")
                }
            }
        }
        
        newsAPI.getTopHeadlines(sources:sourceString, category: NewsStrikePageViewController.category, language: .en, country: .all){ result in
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
        if let url = headlines[currentIndex].urlToImage{
            viewController.setVCPropertiesFor(url: url , headline: headlines[currentIndex].title, article: headlines[currentIndex].articleDescription ?? "Article Description not provided by provider") 
        }
        
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

