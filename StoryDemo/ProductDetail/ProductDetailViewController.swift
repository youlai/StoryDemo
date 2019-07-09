//
//  ProductDetailViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var tableview:UITableView!
    
    var headView:UIView!
    var footerView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //HeadView
        headView = DetailHeaderView.initWithXibName(xib: "DetailHeaderView") as! UIView
        footerView = DetailFooterView.initWithXibName(xib: "DetailFooterView") as! UIView
        
        headView.frame=CGRect(x: 0, y: 0, width: screenW, height: 80)
        footerView.frame=CGRect(x: 0, y: screenH-40, width: screenW, height: 40)
        print(headView.width)
        self.view.addSubview(headView)
        self.view.addSubview(footerView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
