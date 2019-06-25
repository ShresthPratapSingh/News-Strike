//
//  ChangeUXTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 21/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class CustomiseUXTableViewCell: UITableViewCell {
    
    enum StateValues{
        case pageScroll
        case tableView
    }
    
    
    var isToggleON : Bool = false
    @IBOutlet weak var toggleButtonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func toggleState(parentVC : UITabBarController) {
        if self.isToggleON{
            self.toggleButtonImageView.image = UIImage(named: "toggle_off")
            self.isToggleON = false
            changeUXTo(identifier: .pageScroll,parentVC)
        }else{
            self.toggleButtonImageView.image = UIImage(named: "toggle_on")
            self.isToggleON = true
            changeUXTo(identifier: .tableView,parentVC)
        }
    }
    
    private func changeUXTo(identifier state : StateValues,_ parent : UITabBarController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch state {
        case .pageScroll:
            let newsStrikePageVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsStrikePageViewController")
            parent.viewControllers?[0] = newsStrikePageVC
        case .tableView:
            let newsStrikeTableVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsStrikeTableViewController")
            parent.viewControllers?[0] = newsStrikeTableVC
        }
        parent.setViewControllers(parent.viewControllers, animated: true)
    }
}
