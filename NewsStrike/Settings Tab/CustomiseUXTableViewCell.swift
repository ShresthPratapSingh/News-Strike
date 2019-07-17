//
//  ChangeUXTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 21/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class CustomiseUXTableViewCell: UITableViewCell {
    
    
    private var userDefaults = UserDefaults.standard
    
    @IBOutlet weak var labelWidthconstraint: NSLayoutConstraint!
    
    private var indexPath : IndexPath?
    
    var isToggleON :Bool!{
        didSet{
            if isToggleON{
                toggleButtonImageView.image = UIImage(named: "toggle_on")
            }else{
                toggleButtonImageView.image = UIImage(named: "toggle_off")
            }
        }
    }
    
    @IBOutlet weak var toggleButtonImageView: UIImageView!
    
    func setToggleIsSelected(isSelected: Bool) {
        isToggleON = isSelected
    }
}
