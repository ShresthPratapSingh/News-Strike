//
//  ViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 08/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsStrikeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    var isBackButtonEnabled = false
    var category : Categories = .all
    private var dataModelInstance = DataModel.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.askProviderForNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let loadingVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loadingViewController") as! LoadingAnimator)
        
        self.present(loadingVC, animated: false, completion: nil)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        dataModelInstance.delegate = self
        tableView.tableFooterView = UIView()
        
        
        if isBackButtonEnabled{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            self.navigationItem.leftBarButtonItem?.tintColor = .red
        }
    }
    
    @objc private func done(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    private var headlinesData = [NewsArticle](){
        didSet{
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            tableView.reloadData()
        }
    }
    
    func askProviderForNews(){
        if category == Categories.all{
            if dataModelInstance.topHeadlinesData != nil,!dataModelInstance.sourceDataHasChanged{
                headlinesData = dataModelInstance.topHeadlinesData!
            }else{
                dataModelInstance.getNewsData(fromSources: dataModelInstance.getSelectedSources())
            }
        }else{
            dataModelInstance.getNewsData(fromCategories: [category])
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlinesData.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell")
        cell?.selectionStyle = .none
        if let newsCell = cell as? NewsTableViewCell{
            newsCell.sourceLabel.text = headlinesData[indexPath.item].sourceName
            newsCell.headlineLabel.text = headlinesData[indexPath.item].articleTitle
            
            newsCell.timeLabel.text = headlinesData[indexPath.item].publishedAt
            
            if let url = headlinesData[indexPath.item].articleImageURL{
                DispatchQueue.global(qos: .userInitiated).async {
                    if let imageData = try? Data(contentsOf: url){
                        DispatchQueue.main.async {
                            newsCell.articleImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func recievedDataSuccesfully(articleData: [NewsArticle]) {
        self.headlinesData = articleData
    }
    
    func failedRecievingData(dueTo error: Error) {
        
    }
}

