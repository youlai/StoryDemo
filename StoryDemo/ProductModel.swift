//
//  ProductModel.swift
//  StoryDemo
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import Foundation
class Product {
    var icon:String=""
    var name:String=""
    var price:Double=0
    var oldPrice:Double=0
    init(icon:String,name:String,price:Double,oldPrice:Double) {
        self.icon=icon
        self.name=name
        self.price=price
        self.oldPrice=oldPrice
    }
}
