//
//  IndividualCategoryTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 23/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class IndividualSourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    

    private var userDefaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
