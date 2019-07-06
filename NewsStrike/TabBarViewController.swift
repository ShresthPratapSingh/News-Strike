//
//  TabBarViewController.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 29/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let shouldUseTableViewUI = UserDefaults.standard.bool(forKey: Keys.isPrefferedUIPageScroll)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        if shouldUseTableViewUI {
            let newsStrikeTableVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsStrikeTableViewController")
            if viewControllers?.count ?? 0 > 0 {
                viewControllers![0] = newsStrikeTableVC
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
