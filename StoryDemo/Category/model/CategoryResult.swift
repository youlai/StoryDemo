//
//  CategoryResult.swift
//  StoryDemo
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CategoryResult {
    var Success: String?
    var Categorys = [Category]()
    
    init(json: JSON) {
        Success = json["Success"].stringValue
        Categorys = json["Category"].arrayValue.compactMap({Category(json: $0)})
    }
}
struct Category {
    var Image: String?
    var DisplaySequence: Int = 0
    var SubCategories = [Category]()
    var Depth: Int = 0
    var Name: String?
    var Id: Int = 0
    
    init(json: JSON) {
        Image = json["Image"].stringValue
        DisplaySequence = json["DisplaySequence"].intValue
        SubCategories = json["SubCategories"].arrayValue.compactMap({Category(json: $0)})
        Depth = json["Depth"].intValue
        Name = json["Name"].stringValue
        Id = json["Id"].intValue
    }
}

