//
//  NewsViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 17/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    
    private var imageUrl: URL!
    private var descriptionText: String?
    private var headlineText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageData = try? Data(contentsOf: self.imageUrl) {
            self.articleImageView.image = UIImage(data: imageData)
        }else{
            articleImageView.image = UIImage(contentsOfFile: "placeholder")
        }
        self.articleTitleLabel.text = self.headlineText
        self.articleContentLabel.text = self.descriptionText
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

