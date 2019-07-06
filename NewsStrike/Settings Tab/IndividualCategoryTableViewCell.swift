//
//  IndividualCategoryTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 23/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class IndividualCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
//    var isCategorySelected : Bool!{
//        didSet{
//            saveState()
//        }
//    }

    private var userDefaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        extractState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func saveState(){
        userDefaults.set(categoryImageView.isHidden, forKey: Keys.isCategorySelected)
    }
    
    func extractState(){
        categoryImageView.isHidden = userDefaults.bool(forKey: Keys.isCategorySelected)
    }

}
