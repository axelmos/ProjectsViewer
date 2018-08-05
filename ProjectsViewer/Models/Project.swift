//
//  Project.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 05/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import Foundation

struct Project {
    
    var id: String?
    var name: String?
    var description: String?
    var logo: String?
    var startDate: String?
    var endDate: String?
    
    init(dict: Dictionary<String, AnyObject>) throws  {
        
        if let _id = dict["id"] as? String {
            id = _id
        }
        
        if let _name = dict["name"] as? String {
            name = _name
        }
        
        if let _description = dict["description"] as? String {
            description = _description
        }
        
        if let _logo = dict["logo"] as? String {
            logo = _logo
        }
        
        if let _startDate = dict["startDate"] as? String {
            startDate = _startDate
        }
        
        if let _endDate = dict["endDate"] as? String {
            endDate = _endDate
        }
    }
}
