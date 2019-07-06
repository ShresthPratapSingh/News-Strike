//
//  SettingsDataModel.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 29/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import UIKit

class SettingsDataModel: NSObject {
    
    private(set) static var data = [["Switch to tableView"],
                ["Buisness","Sports","Health","Science","Entertainment","Technology","General","Everything"]]
    
    func sectionTitlesFor(section:Int) -> String {
        switch section {
        case 0:
            return "CustomiseUX"
        default:
            return "Select Categories"
        }
    }
}
