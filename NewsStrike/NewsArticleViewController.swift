//
//  NewsArticleViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 13/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit
import SafariServices

class NewsArticleViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleHeadlineLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var visitSourceButton: UIButton!
    @IBAction func visitSource(_ sender: Any) {
        if let url = articleURL{
            let safariVC = SFSafariViewController(url: url)
            safariVC.preferredControlTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            safariVC.preferredBarTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.present(safariVC, animated: true)
        }
    }
    @IBOutlet weak var articleImageHeightConstraint: NSLayoutConstraint!
    var isPageScrollEnabled = UserDefaults.standard.bool(forKey: Keys.isPrefferedUIPageScroll)
    
    private var imageUrl: URL?
    private var descriptionText: String?
    private var headlineText: String?
    private var articleURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        
        articleImageHeightConstraint.constant = screenSize.height*0.40
        
        if self.parent as? NewsStrikePageViewController != nil{
            scrollView.isScrollEnabled = false
        }
        if let url = self.imageUrl, let imageData = try? Data(contentsOf: url) {
            self.articleImageView.image = UIImage(data: imageData)
        }else{
            articleImageView.image = UIImage(contentsOfFile: "placeholder")
        }
        self.articleHeadlineLabel.text = self.headlineText
        self.articleDescriptionLabel.text = self.descriptionText
        
        if isPageScrollEnabled{
            self.view.bringSubviewToFront(dismissButton)
        }
        visitSourceButton.layer.cornerRadius = 20
        visitSourceButton.layer.masksToBounds = true
        self.view.bringSubviewToFront(visitSourceButton)
    }
    
    @IBAction func dismissVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func setVCPropertiesFor(urlToImage:URL, urlToArticle:URL, headline:String, article:String){
        self.imageUrl = urlToImage
        self.headlineText = headline
        self.descriptionText = article
        self.articleURL = urlToArticle
    }
}
