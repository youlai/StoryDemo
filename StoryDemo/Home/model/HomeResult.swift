//
//Created by ESJsonFormatForMac on 19/07/06.
//

import UIKit

class ESRootClass: NSObject {
    
    var TotalProduct: String?
    
    var Slide: [Slide]?
    
    var CustomerServices: [String]?
    
    var Product: [Products]?
    
    var Icon: [Icon]?
    
    var Topic: [Topic]?
    
    var Success: String?
    
}
class Slide: NSObject {
    
    var Url: String?
    
    var Desc: String?
    
    var ImageUrl: String?
    
}

class Icon: NSObject {
    
    var Url: String?
    
    var Desc: String?
    
    var ImageUrl: String?
    
}

class Products: NSObject {
    
    var Discount: String?
    
    var ImageUrl: String?
    
    var Id: String?
    
    var CommentsCount: String?
    
    var Url: String?
    
    var MarketPrice: String?
    
    var Name: String?
    
    var SalePrice: String?
    
}

class Topic: NSObject {
    
    var Url: String?
    
    var ImageUrl: String?
    
}

