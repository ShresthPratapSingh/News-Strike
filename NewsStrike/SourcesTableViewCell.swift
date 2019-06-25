//
//  SourcesTableViewCell.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 23/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    private var availableSources = ["ABC News","CNN","Business Insider","CBS News","CNBC","Daily Mail","Crypto Coins News","Fortune","Fox News","Google News","Nat Geo","NBC News","Techcrunch CN","Techcrunch","Techradar","The New York Times","Time","The Times of India","The Economist","Google News(In)"]

    @IBOutlet weak var individualSourceTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        individualSourceTableView.reloadData()
        heightConstraint.constant = individualSourceTableView.contentSize.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualSourceTableViewCell", for: indexPath) as! IndividualSourceTableViewCell
        cell.sourceLabel.text = availableSources[indexPath.item]
        
        if cell.isSourceSelected{
            cell.sourceSelectedImageView.isHidden = false
        }else{
            cell.sourceSelectedImageView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellTapped = tableView.cellForRow(at: indexPath) as! IndividualSourceTableViewCell
        cellTapped.isSourceSelected = cellTapped.isSourceSelected ? false : true
        
    }

}
