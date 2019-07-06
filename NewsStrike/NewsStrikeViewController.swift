//
//  ViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 08/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsStrikeViewController: UITableViewController{

    
    private var dataModelInstance = DataModel.sharedInstance
    var isBackButtonEnabled = false
    var category : Categories = .all
//    private var loadingAlert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModelInstance.delegate = self
        if isBackButtonEnabled{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            self.navigationItem.leftBarButtonItem?.tintColor = .white
        }
//        present(loadingAlert,animated: true)
        self.askProviderForNews()
    }
    
    @objc private func done(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //TODO:- remove this and ask from all sources.
    
    private var sources : [NewsSources] = [.abcNews,.cnn,.buisnessInsider,.cbsNews,.cnbc,.dailyMail,.cryptoCoinsNews,.fortune,.foxNews,.googleNews,.natGeo,.nbcNews,.techcrunch,.techradar,.theNewYorkTimes,.time,.theTimesOfIndia,.theEconomist,.googleNewsIndia]
    
    private var headlinesData = [NewsArtizxcle](){
        didSet{
            tableView.reloadData()
//            loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlinesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell")
        cell?.selectionStyle = .none
        if let newsCell = cell as? NewsTableViewCell{
            newsCell.sourceLabel.text = headlinesData[indexPath.item].sourceName
            newsCell.headlineLabel.text = headlinesData[indexPath.item].articleTitle
            
            newsCell.timeLabel.text = headlinesData[indexPath.item].publishedAt
            
            if let url = headlinesData[indexPath.item].articleImageURL,let imageData = try? Data(contentsOf: url){
                newsCell.articleImageView.image = UIImage(data: imageData)
            }else{
                newsCell.articleImageView.image = UIImage(contentsOfFile: "placeholder")
            }
        }
        //MARK:- BAD CODE(FORCED UNWRAP)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let imageURL = headlinesData[indexPath.item].articleImageURL{
            if let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "NewsArticleViewController") as? NewsArticleViewController {
                if let headline = headlinesData[indexPath.item].articleTitle,let articleURL = headlinesData[indexPath.item].articleURL{
                    vc.setVCPropertiesFor(urlToImage:imageURL,urlToArticle:articleURL, headline: headline , article: headlinesData[indexPath.item].articleDescription ?? "Article Description Not Provided By Server")
                }
                
                self.present(
                    vc,
                    animated: true,
                    completion: nil
                )
            }
        }
    }


}

extension NewsStrikeViewController: DataModelDelegateProtocol {
    
    func recievedDataSuccesfully(articleData: [NewsArtizxcle]) {
        self.headlinesData = articleData
    }
    
    func failedRecievingData(withError error: Error) {
        
    }
}

