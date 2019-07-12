//
//  GiftListResult.swift
//  StoryDemo
//
//  Created by mac on 2019/7/12.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import Foundation
import SwiftyJSON
struct mGiftListResult {
    var GiftMaxPage: Int = 0
    var CouponTotal: Int = 0
    var MemberGradeName: String?
    var CouponMaxPage: Int = 0
    var GiftListNew = [mGiftListNew]()
    var GiftPageSize: Int = 0
    var GiftList: String?
    var CouponPageSize: Int = 0
    var MemberAvailableIntegrals: Int = 0
    var GiftTotal: Int = 0
    
    init(json: JSON) {
        GiftMaxPage = json["GiftMaxPage"].intValue
        CouponTotal = json["CouponTotal"].intValue
        MemberGradeName = json["MemberGradeName"].stringValue
        CouponMaxPage = json["CouponMaxPage"].intValue
        GiftListNew = json["GiftListNew"].arrayValue.flatMap({ mGiftListNew(json: $0)})
        GiftPageSize = json["GiftPageSize"].intValue
        GiftList = json["GiftList"].stringValue
        CouponPageSize = json["CouponPageSize"].intValue
        MemberAvailableIntegrals = json["MemberAvailableIntegrals"].intValue
        GiftTotal = json["GiftTotal"].intValue
    }
}

struct mGiftListNew {
    var StockQuantity: Int = 0
    var NeedGrade: Int = 0
    var GiftValue: Int = 0
    var EndDateStr: String?
    var DefaultShowImage: Int = 0
    var Sequence: Int = 0
    var GiftName: String?
    var NeedIntegral: Int = 0
    var AddDateStr: String?
    var RealSales: Int = 0
    var SalesStatus: Int = 0
    var Id: Int = 0
    var GetSalesStatus: Int = 0
    var LimtQuantity: Int = 0
    var ImagePath: String?
    var Description: String?
    var NeedGradeName: String?
    var ShowImagePath: String?
    var VirtualSales: Int = 0
    var ShowSalesStatus: String?
    var ShowLimtQuantity: String?
    var GradeIntegral: Int = 0
    var SumSales: Int = 0
    
    init(json: JSON) {
        StockQuantity = json["StockQuantity"].intValue
        NeedGrade = json["NeedGrade"].intValue
        GiftValue = json["GiftValue"].intValue
        EndDateStr = json["EndDateStr"].stringValue
        DefaultShowImage = json["DefaultShowImage"].intValue
        Sequence = json["Sequence"].intValue
        GiftName = json["GiftName"].stringValue
        NeedIntegral = json["NeedIntegral"].intValue
        AddDateStr = json["AddDateStr"].stringValue
        RealSales = json["RealSales"].intValue
        SalesStatus = json["SalesStatus"].intValue
        Id = json["Id"].intValue
        GetSalesStatus = json["GetSalesStatus"].intValue
        LimtQuantity = json["LimtQuantity"].intValue
        ImagePath = json["ImagePath"].stringValue
        Description = json["Description"].stringValue
        NeedGradeName = json["NeedGradeName"].stringValue
        ShowImagePath = json["ShowImagePath"].stringValue
        VirtualSales = json["VirtualSales"].intValue
        ShowSalesStatus = json["ShowSalesStatus"].stringValue
        ShowLimtQuantity = json["ShowLimtQuantity"].stringValue
        GradeIntegral = json["GradeIntegral"].intValue
        SumSales = json["SumSales"].intValue
    }
}
