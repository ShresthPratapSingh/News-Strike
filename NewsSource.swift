//
//  NewsSource.swift
//  NewsStrike
//
//  Created by Shresth Pratap Singh on 11/07/19.
//  Copyright © 2019 Shresth Pratap Singh. All rights reserved.
//

import Foundation
class NewsSource:NSObject{
    var sourceName : String?
    var sourceID: String?
    var isSelected = false
    
    init(_ responseDictionary: [String:String?]) {
        if let name = responseDictionary["name"]{
            sourceName = name
        }
        if let id = responseDictionary["id"]{
            sourceID = id
        }
    }
}
