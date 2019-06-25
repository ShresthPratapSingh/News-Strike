//
//  CategoriesTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 23/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {

    private var availableCategories = ["Buisness","Sports","Health","Science","Entertainment","Technology","General","Everything"]
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.reloadData()
        heightConstraint.constant = categoriesTableView.contentSize.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "IndividualCategoryCell", for: indexPath) as! IndividualCategoryTableViewCell
        cell.categoryLabel.text = availableCategories[indexPath.item]
       
        if cell.isCategorySelected {
            cell.categoryImageView.isHidden = false
        } else{
            cell.categoryImageView.isHidden = true
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellTapped = tableView.cellForRow(at: indexPath) as! IndividualCategoryTableViewCell
        cellTapped.isCategorySelected = cellTapped.isCategorySelected ? false : true
        tableView.reloadData()
    }

}
