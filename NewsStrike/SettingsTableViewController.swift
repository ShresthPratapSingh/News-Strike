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
    }
    
    static var rootTabBar : UITabBarController?
    
    private var sectionTitlesFor = ["Customise UX","Select Categories","Select Sources"]
    private var sectionImagesFor = ["layers","categories_colour","light_bulb"]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitlesFor.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let headerImage = UIImageView(image: UIImage(named:sectionImagesFor[section]))
        headerImage.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(headerImage)
        
        let headerLabel = UILabel(frame: CGRect(x: 45, y: 5, width: 200, height: 35))
        headerLabel.text = sectionTitlesFor[section]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomiseUX", for: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesTableViewCell", for: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "No Data", for: indexPath)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let cell = tableView.cellForRow(at: indexPath) as! CustomiseUXTableViewCell
            let parentTabBarController = self.parent as! UITabBarController
            cell.toggleState(parentVC: parentTabBarController)
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
