//
//  ProductDetailResult.swift
//  StoryDemo
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import Foundation
import SwiftyJSON

struct mProductDetailResult {
    var Product: mProduct!
    var ColorAlias: String?
    var IsOpenStore: Bool = false
    var IsDistribution: Bool = false
    var ProductAttributeInfos = [String]()
    var IsFightGroupActive: Bool = false
    var userId: Int = 0
    var MaxSaleCount: Int = 0
    var Second: Int = 0
    var IsOnLimitBuy: String?
    var FreightFee: Int = 0
    var SizeAlias: String?
    var CashDepositsServer: mCashDepositsServer?
    var Free: String?
    var BonusRandomAmountStart: Int = 0
    var ActiveStatus: Int = 0
    var Success: String?
    var BonusRandomAmountEnd: Int = 0
    var fullDiscount: String?
    var ActiveId: Int = 0
    var IsFavoriteShop: Bool = false
    var VShopLog: String?
    var Title: String?
    var CustomerServices = [mCustomerServices]()
    var BonusGrantPrice: Int = 0
    var VersionAlias: String?
    var ProductAddress: String?
    var Brokerage: String?
    var IsPromoter: Bool = false
    var BonusCount: Int = 0
    var Shop: mShop!
    
    init(json: JSON) {
        Product = mProduct(json: json["Product"])
        ColorAlias = json["ColorAlias"].stringValue
        IsOpenStore = json["IsOpenStore"].boolValue
        IsDistribution = json["IsDistribution"].boolValue
        ProductAttributeInfos = json["ProductAttributeInfos"].arrayValue.compactMap({$0.stringValue})
        IsFightGroupActive = json["IsFightGroupActive"].boolValue
        userId = json["userId"].intValue
        MaxSaleCount = json["MaxSaleCount"].intValue
        Second = json["Second"].intValue
        IsOnLimitBuy = json["IsOnLimitBuy"].stringValue
        FreightFee = json["FreightFee"].intValue
        SizeAlias = json["SizeAlias"].stringValue
        CashDepositsServer = mCashDepositsServer(json: json["CashDepositsServer"])
        Free = json["Free"].stringValue
        BonusRandomAmountStart = json["BonusRandomAmountStart"].intValue
        ActiveStatus = json["ActiveStatus"].intValue
        Success = json["Success"].stringValue
        BonusRandomAmountEnd = json["BonusRandomAmountEnd"].intValue
        fullDiscount = json["fullDiscount"].stringValue
        ActiveId = json["ActiveId"].intValue
        IsFavoriteShop = json["IsFavoriteShop"].boolValue
        VShopLog = json["VShopLog"].stringValue
        Title = json["Title"].stringValue
        CustomerServices = json["CustomerServices"].arrayValue.compactMap({ mCustomerServices(json: $0)})
        BonusGrantPrice = json["BonusGrantPrice"].intValue
        VersionAlias = json["VersionAlias"].stringValue
        ProductAddress = json["ProductAddress"].stringValue
        Brokerage = json["Brokerage"].stringValue
        IsPromoter = json["IsPromoter"].boolValue
        BonusCount = json["BonusCount"].intValue
        Shop = mShop(json: json["Shop"])
    }
}

struct mShop {
    var PackMark: Int = 0
    var CouponCount: Int = 0
    var ProductAndDescription: Int = 0
    var ProductNum: Int = 0
    var FavoriteShopCount: Int = 0
    var VShopId: Int = 0
    var ComprehensiveMark: Int = 0
    var ServiceMark: Int = 0
    var ProductMark: Int = 0
    var CompanyName: String?
    var Id: Int = 0
    var Phone: String?
    var FreeFreight: Int = 0
    var SellerDeliverySpeed: Int = 0
    var Name: String?
    var Address: String?
    var SellerServiceAttitude: Int = 0
    
    init(json: JSON) {
        PackMark = json["PackMark"].intValue
        CouponCount = json["CouponCount"].intValue
        ProductAndDescription = json["ProductAndDescription"].intValue
        ProductNum = json["ProductNum"].intValue
        FavoriteShopCount = json["FavoriteShopCount"].intValue
        VShopId = json["VShopId"].intValue
        ComprehensiveMark = json["ComprehensiveMark"].intValue
        ServiceMark = json["ServiceMark"].intValue
        ProductMark = json["ProductMark"].intValue
        CompanyName = json["CompanyName"].stringValue
        Id = json["Id"].intValue
        Phone = json["Phone"].stringValue
        FreeFreight = json["FreeFreight"].intValue
        SellerDeliverySpeed = json["SellerDeliverySpeed"].intValue
        Name = json["Name"].stringValue
        Address = json["Address"].stringValue
        SellerServiceAttitude = json["SellerServiceAttitude"].intValue
    }
}

struct mCashDepositsServer {
    var IsSevenDayNoReasonReturn: Bool = false
    var CanSelfTake: Bool = false
    var IsCustomerSecurity: Bool = false
    var IsTimelyShip: Bool = false
    
    init(json: JSON) {
        IsSevenDayNoReasonReturn = json["IsSevenDayNoReasonReturn"].boolValue
        CanSelfTake = json["CanSelfTake"].boolValue
        IsCustomerSecurity = json["IsCustomerSecurity"].boolValue
        IsTimelyShip = json["IsTimelyShip"].boolValue
    }
}

struct mProduct {
    var MinSalePrice: Int = 0
    var ShortDescription: String?
    var NicePercent: Int = 0
    var ParentCategoryName: String?
    var AuditStatus: Int = 0
    var BrandName: String?
    var CommentCount: Int = 0
    var ProductId: Int = 0
    var ProductDescription: String!
    var IsOnLimitBuy: Bool = false
    var BrandId: Int = 0
    var ImagePath = [String]()
    var ProductSaleStatus: Int = 0
    var ParentCategoryId: Int = 0
    var IsFavorite: Bool = false
    var CategoryName: String?
    var IsInstall: Bool = false
    var Consultations: Int = 0
    var MarketPrice: Int = 0
    var ProductName: String?
    var CategoryId: Int = 0
    
    init(json: JSON) {
        MinSalePrice = json["MinSalePrice"].intValue
        ShortDescription = json["ShortDescription"].stringValue
        NicePercent = json["NicePercent"].intValue
        ParentCategoryName = json["ParentCategoryName"].stringValue
        AuditStatus = json["AuditStatus"].intValue
        BrandName = json["BrandName"].stringValue
        CommentCount = json["CommentCount"].intValue
        ProductId = json["ProductId"].intValue
        ProductDescription = json["ProductDescription"].stringValue
        IsOnLimitBuy = json["IsOnLimitBuy"].boolValue
        BrandId = json["BrandId"].intValue
        ImagePath = json["ImagePath"].arrayValue.compactMap({$0.stringValue})
        ProductSaleStatus = json["ProductSaleStatus"].intValue
        ParentCategoryId = json["ParentCategoryId"].intValue
        IsFavorite = json["IsFavorite"].boolValue
        CategoryName = json["CategoryName"].stringValue
        IsInstall = json["IsInstall"].boolValue
        Consultations = json["Consultations"].intValue
        MarketPrice = json["MarketPrice"].intValue
        ProductName = json["ProductName"].stringValue
        CategoryId = json["CategoryId"].intValue
    }
}

struct mCustomerServices {
    var Id: Int = 0
    var TerminalType: Int = 0
    var Name: String?
    var ServerStatus: Int = 0
    var Tool: Int = 0
    var AccountCode: String?
    var `Type`: Int = 0
    var ShopId: Int = 0
    
    init(json: JSON) {
        Id = json["Id"].intValue
        TerminalType = json["TerminalType"].intValue
        Name = json["Name"].stringValue
        ServerStatus = json["ServerStatus"].intValue
        Tool = json["Tool"].intValue
        AccountCode = json["AccountCode"].stringValue
        Type = json["Type"].intValue
        ShopId = json["ShopId"].intValue
    }
}

