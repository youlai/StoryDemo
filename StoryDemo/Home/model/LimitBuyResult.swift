//
//  LimitBuyResult.swift
//  StoryDemo
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LimitBuyResult {
    var List = [Lists]()
    var Total: Int = 0
    
    init(json: JSON) {
        List = json["List"].arrayValue.compactMap({ Lists(json: $0)})
        Total = json["Total"].intValue
    }
}

struct Lists {
    var EndDate: String?
    var MarketPrice: Double = 0
    var MinPrice: Double = 0
    var ProductAttributeInfos = [String]()
    var Stock: Int = 0
    var ProductImg: String?
    var SaleCount: Int = 0
    var ProductName: String?
    var ProductId: Int = 0
    var Id: Int = 0
    
    init(json: JSON) {
        EndDate = json["EndDate"].stringValue
        MarketPrice = json["MarketPrice"].doubleValue
        MinPrice = json["MinPrice"].doubleValue
        ProductAttributeInfos = json["ProductAttributeInfos"].arrayValue.compactMap({$0.stringValue})
        Stock = json["Stock"].intValue
        ProductImg = json["ProductImg"].stringValue
        SaleCount = json["SaleCount"].intValue
        ProductName = json["ProductName"].stringValue
        ProductId = json["ProductId"].intValue
        Id = json["Id"].intValue
    }
}
