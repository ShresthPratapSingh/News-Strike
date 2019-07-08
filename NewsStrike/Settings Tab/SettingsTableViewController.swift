//
//  SettingsTableViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 21/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
    
    var dataModel = SettingsDataModel()
    
    static var rootTabBar : UITabBarController?
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsDataModel.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SettingsDataModel.data[section].count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        
        let imageName:String
        switch section{
        case 0 :
            imageName = "layers"
        case 1:
            imageName = "categories_colour"
        default:
            imageName = "placeholder"
        }
        
        let headerImage = UIImageView(image: UIImage(named:imageName))
        headerImage.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(headerImage)
        
        let headerLabel = UILabel(frame: CGRect(x: 45, y: 5, width: 200, height: 35))
        headerLabel.text = dataModel.sectionTitlesFor(section:section)
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "System Bold", size: CGFloat(22))
        headerLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(22))
        view.addSubview(headerLabel)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    static var getCell : UITableViewCell?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomiseUX", for: indexPath) as! CustomiseUXTableViewCell
            cell.setToggleIsSelected(isSelected: UserDefaults.standard.bool(forKey: Keys.isPrefferedUIPageScroll))
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualCategoryCell", for: indexPath) as! IndividualCategoryTableViewCell
            cell.categoryLabel.text = SettingsDataModel.data[indexPath.section][indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "No Data", for: indexPath)
        }
        
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.section{
            case 0:
                let currentState = UserDefaults.standard.bool(forKey: Keys.isPrefferedUIPageScroll)
                UserDefaults.standard.set(!currentState, forKey: Keys.isPrefferedUIPageScroll)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if currentState{
                    let newsStrikeTableVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsStrikePageViewController")
                    (self.parent as? UITabBarController)?.viewControllers?[0] = newsStrikeTableVC
                }
                else {
                    let newsStrikePageVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsStrikeTableViewController")
                    (self.parent as? UITabBarController)?.viewControllers?[0] = newsStrikePageVC
                }
                
                    if let cell = tableView.cellForRow(at: indexPath) as? CustomiseUXTableViewCell {
                        cell.setToggleIsSelected(isSelected: !currentState)
                    }
            case 1:
                 let cellTapped = tableView.cellForRow(at: indexPath) as! IndividualCategoryTableViewCell
                cellTapped.categoryImageView.isHidden = !cellTapped.categoryImageView.isHidden
                tableView.reloadData()
            default:
                return
            }
    }

}
