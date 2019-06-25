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
            NewsStrikePageViewController.category = .business
        case "Sports":
            NewsStrikePageViewController.category = .sports
        case "Health":
            NewsStrikePageViewController.category = .health
        case "Science":
            NewsStrikePageViewController.category = .science
        case "Entertainment":
            NewsStrikePageViewController.category = .entertainment
        case "Technology":
            NewsStrikePageViewController.category = .technology
        case "General":
            NewsStrikePageViewController.category = .general
        default:
            NewsStrikePageViewController.category = .all
        }
        
        let categoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsStrikePageViewController") as! NewsStrikePageViewController
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
}
