//
//  ShopViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit
import SwiftTTPageController

class ShopViewController: UIViewController,TTHeadViewDelegate,TTPageViewControllerDelegate {


    @IBOutlet weak var search_view: UIView!
    var vcs:[UIViewController]! = []
    var headView:TTHeadView!
    var pagevc:TTPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search_view.layer.cornerRadius=5
//        search_view.backgroundColor="#ff4500".color()
        
        let titles = ["全部","衣服","裤子","鞋子","帽子","热水器","水龙头","饰品","零食"]
        
        let _w :CGFloat = 50.0 * CGFloat(titles.count) < screenW ? 60 : 55
        var attri = TTHeadTextAttribute()
        attri.itemWidth = _w
        attri.defaultFontSize = 13
        attri.selectedFontSize = 13
        attri.selectedTextColor = "#ff4500".color()
        attri.bottomLineColor = "#ff4500".color()
        attri.bottomLineHeight = 2
        
        let bg = UIView.init(frame: CGRect (x: 0, y: 100, width: screenW, height: 35));
        
        headView = TTHeadView (frame: CGRect (x: 0, y: 0, width: screenW, height: 35), titles: titles, delegate: self, textAttributes: attri)
        headView.backgroundColor="#ff4500".color()
        bg.addSubview(headView)
        let frame = CGRect (x: 0, y: 140, width: screenW, height: screenH-140)
        for type in titles {
            vcs.append(ProductCollectionViewController(type: type))
        }
        pagevc = TTPageViewController.init(controllers: vcs, frame: frame, delegate: self)
        
        self.addChildViewController(pagevc)
        self.view.addSubview(bg)
        self.view.addSubview(pagevc.view)
    }
    
    func tt_headViewSelectedAt(_ index: Int) {
        pagevc.scrollToPageAtIndex(index)
    }
    
    func tt_pageControllerSelectedAt(_ index: Int) {
        headView.scrollToItemAtIndex(index)
    }
}
