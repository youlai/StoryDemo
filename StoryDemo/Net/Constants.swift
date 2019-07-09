//
//  Constants.swift
//  StoryDemo
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019年 zhkj. All rights reserved.
//
import UIKit
import Foundation

let screenW=UIScreen.main.bounds.width
let screenH=UIScreen.main.bounds.height

let app_key="himalltest"
let secret="has2f5zbd4"

let BASE_URL = "http://mall.xigyu.com/"
let home_list_url = "api/home/Get"//首页
let home_json="AppHome/data/default.json"//首页
let home_limit="api/LimitTimeBuy/GetLismitBuyList"//抢购列表
let cate_all="api/Category/GetCategories"//所有分类


///
let Loading = {HUD.show()}
let Loadingwith:((String)->()) = {str in
    HUD.show(withStatus:str)
}

let Dismiss = {HUD.dismiss()}

public func SignTopRequest(params:Dictionary<String,String>) -> String {
    var str = ""
    let sortedKeys = Array(params.keys).sorted()
    for key in sortedKeys {
        str+=key.lowercased()+params[key]!
    }
    return md5(strs: str+secret).uppercased()
}
public func md5(strs:String) ->String!{
    let str = strs.cString(using: String.Encoding.utf8)
    let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
    CC_MD5(str!, strLen, result)
    let hash = NSMutableString()
    for i in 0 ..< digestLen {
        hash.appendFormat("%02x", result[i])
    }
    result.deinitialize()
    return String(format: hash as String)
}
public func getTimestamp() ->String!{
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"// 自定义时间格式
    let timestamp = dateformatter.string(from: Date())
    return timestamp
}
