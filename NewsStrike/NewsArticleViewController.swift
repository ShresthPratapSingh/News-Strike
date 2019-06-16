//
//  NewsArticleViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 13/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsArticleViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleHeadlineLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!

    
    @IBOutlet weak var dismissButton: UIButton!
    
    private var imageUrl: URL?
    private var descriptionText: String?
    private var headlineText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = self.imageUrl, let imageData = try? Data(contentsOf: url) {
            self.articleImageView.image = UIImage(data: imageData)
        }else{
            articleImageView.image = UIImage(contentsOfFile: "placeholder")
        }
        self.articleHeadlineLabel.text = self.headlineText
        self.articleDescriptionLabel.text = self.descriptionText
        
        
        self.view.bringSubviewToFront(dismissButton)
    }
    
    @IBAction func dismissVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func setVCPropertiesFor(url:URL, headline:String, article:String){
        self.imageUrl = url
        self.headlineText = headline
        self.descriptionText = article
    }
}
