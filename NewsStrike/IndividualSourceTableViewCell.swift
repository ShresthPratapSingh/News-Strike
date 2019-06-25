//
//  IndividualSourceTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 23/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class IndividualSourceTableViewCell: UITableViewCell {
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceSelectedImageView: UIImageView!
    
    var isSourceSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
