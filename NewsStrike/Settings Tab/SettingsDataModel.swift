//
//  SettingsDataModel.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 29/06/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import Foundation

protocol SettingsDataModelDelegateProtocol {
    func dataUpdatedSuccesfully()
}

class SettingsDataModel: NSObject {
    override init() {
        super.init()
    }
    static var delegate : SettingsDataModelDelegateProtocol?
    private let apiManager = NewsAPIManager(apiKey: "f1302092afc14ebe95c72a4f74affa92")
    
    static var data = [["Switch to tableView"],[]]
    
    func sectionTitlesFor(section:Int) -> String {
        
        switch section {
        case 0:
            return "CustomiseUX"
        default:
            return "Select Sources"
        }
    }
}
