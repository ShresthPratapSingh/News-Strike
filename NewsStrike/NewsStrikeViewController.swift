//
//  ViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 08/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit
import NewsAPISwift

class NewsStrikeViewController: UITableViewController {
    
    private var loadingAlert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            self.askProviderForNews()
        }
        present(loadingAlert,animated: true)
    }
    
    private var sourceString = ["abc-news","cnn","business-insider","cbs-news","cnbc","daily-mail","crypto-coins-news","fortune","fox-news","google-news","national-geographic","nbc-news","techcrunch-cn","techcrunch","techradar","the-new-york-times","time","the-times-of-india","the-economist","google-news-in"]
    
    private var headlines = [NewsArticle]()
    
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
                    self.tableView.reloadData()
                    self.loadingAlert.dismiss(animated: true)
                }
                break
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell")
        if let newsCell = cell as? NewsTableViewCell{
            newsCell.sourceLabel.text = headlines[indexPath.item].source.name
            newsCell.headlineLabel.text = headlines[indexPath.item].title
            
            let timeInHours = Int((headlines[indexPath.item].publishedAt.timeIntervalSinceNow/3600)).description
            newsCell.timeLabel.text = "\(timeInHours) hours ago"
            if let url = headlines[indexPath.item].urlToImage,let imageData = try? Data(contentsOf: url){
                newsCell.articleImageView.image = UIImage(data: imageData)
            }else{
                newsCell.articleImageView.image = UIImage(contentsOfFile: "placeholder")
            }
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let url = headlines[indexPath.item].urlToImage{
            if let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "identifier") as? NewsArticleViewController {
                vc.setVCPropertiesFor(url: url, headline: headlines[indexPath.item].title, article: headlines[indexPath.item].articleDescription ?? "Article Description Not Provided By Server")
                
                self.present(
                    vc,
                    animated: true,
                    completion: nil
                )
            }
        }
    }
    
}

