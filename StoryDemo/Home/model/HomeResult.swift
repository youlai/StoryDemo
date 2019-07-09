//
//Created by ESJsonFormatForMac on 19/07/06.
//

import UIKit
import SwiftyJSON

struct HomeResult {
    var Success: String?
    var Product = [Products]()
    var Topic = [Topics]()
    var TotalProduct: String?
    var Icon = [Icons]()
    var Slide = [Slides]()
    
    init(json: JSON) {
        Success = json["Success"].stringValue
        Product = json["Product"].arrayValue.compactMap({ Products(json: $0)})
        Topic = json["Topic"].arrayValue.compactMap({ Topics(json: $0)})
        TotalProduct = json["TotalProduct"].stringValue
        Icon = json["Icon"].arrayValue.compactMap({ Icons(json: $0)})
        Slide = json["Slide"].arrayValue.compactMap({ Slides(json: $0)})
    }
}

struct Products {
    var Url: String?
    var Name: String?
    var CommentsCount: String?
    var SalePrice: String?
    var Discount: String?
    var ImageUrl: String?
    var MarketPrice: String?
    var Id: String?
    
    init(json: JSON) {
        Url = json["Url"].stringValue
        Name = json["Name"].stringValue
        CommentsCount = json["CommentsCount"].stringValue
        SalePrice = json["SalePrice"].stringValue
        Discount = json["Discount"].stringValue
        ImageUrl = json["ImageUrl"].stringValue
        MarketPrice = json["MarketPrice"].stringValue
        Id = json["Id"].stringValue
    }
}

struct Topics {
    var Url: String?
    var ImageUrl: String?
    
    init(json: JSON) {
        Url = json["Url"].stringValue
        ImageUrl = json["ImageUrl"].stringValue
    }
}

struct Icons {
    var Url: String?
    var Desc: String?
    var ImageUrl: String?
    
    init(json: JSON) {
        Url = json["Url"].stringValue
        Desc = json["Desc"].stringValue
        ImageUrl = json["ImageUrl"].stringValue
    }
}

struct Slides {
    var Url: String?
    var Desc: String?
    var ImageUrl: String?
    
    init(json: JSON) {
        Url = json["Url"].stringValue
        Desc = json["Desc"].stringValue
        ImageUrl = json["ImageUrl"].stringValue
    }
}


