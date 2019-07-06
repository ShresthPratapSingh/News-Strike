//
//  CategoriesViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 19/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    private var category : Categories!
    
    private var newsCategories = ["Buisness","Sports","Health","Science","Entertainment","Technology","General","Everything"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell{
            cell.imageView.image = UIImage(named: newsCategories[indexPath.item], in: nil, compatibleWith: nil)
            cell.label.text = "\(newsCategories[indexPath.item])"
            return cell
        }else{ return collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) }
    }
    
    
    //MARK:- BAD CODE
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch newsCategories[indexPath.item] {
        case "Buisness":
            category = .business
        case "Sports":
            category = .sports
        case "Health":
            category = .health
        case "Science":
            category = .science
        case "Entertainment":
            category = .entertainment
        case "Technology":
            category = .technology
        case "General":
            category = .general
        default:
            category = .all
        }
        
        let pageScrollPreffered = UserDefaults.standard.bool(forKey: Keys.isPrefferedUIPageScroll)
        let storyboard = (UIStoryboard(name: "Main", bundle: nil))
        
        if !pageScrollPreffered {
            let pageVC = storyboard.instantiateViewController(withIdentifier: "NewsStrikePageViewController") as! NewsStrikePageViewController
            pageVC.category = self.category
            self.navigationController?.pushViewController(pageVC, animated: true)
        }else{
            let tableNavigationController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsStrikeTableViewController")) as! UINavigationController
            if let tableVC = tableNavigationController.viewControllers.first as? NewsStrikeViewController{
                tableVC.isBackButtonEnabled = true
                tableVC.category = self.category
                self.navigationController?.present(tableNavigationController, animated: true, completion: nil)
            }
        }
    }
}
