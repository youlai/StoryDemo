//
//  ShoppingCartViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "re")
//        if cell==nil {
//            cell=UITableViewCell(style: .subtitle, reuseIdentifier: "re")
//        }
//        if indexPath.row%2==0 {
//            cell?.textLabel?.text="打开 Main.storyboard。 您希望初始视图控制器是一个表视图控制器。 在画布上选择现有的 View Controller，然后按 Delete 删除。 然后将 Table View Controller 从对象库拖动到画布上。 选择 Table View Controller 后，打开其身份检查器，将 class 更改为 ItemsViewController。 最后，打开 Items View Controller 的属性检查器，并选中 Is Initial View Controller。构建并运行您的应用程序。 您应该看到一个空的表视图，如图10.5所示。 作为 UIViewController 的子类，UITableViewController 继承了 view 属性。 当第一次访问此属性时，将调用 loadView() 方法，该方法创建并加载视图对象。 UITableViewController 的视图始终是 UITableView 的一个实例，因此可以用 UITableViewController 的 view 属性来获得明亮，有光泽和空的表视图"
//        }else{
//            cell?.textLabel?.text="啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦"
//        }
        
//        cell?.textLabel?.numberOfLines=0
//        (cell as!TwoLabelTableViewCell).label1.text="简介"
//        if indexPath.row%2==0{
//            (cell as!TwoLabelTableViewCell).label2.text="打开 Main.storyboard。 您希望初始视图控制器是一个表视图控制器。 在画布上选择现有的 View Controller，然后按 Delete 删除。 然后将 Table View Controller 从对象库拖动到画布上。 选择 Table View Controller 后，打开其身份检查器，将 class 更改为 ItemsViewController。 最后，打开 Items View Controller 的属性检查器，并选中 Is Initial View Controller。构建并运行您的应用程序。 您应该看到一个空的表视图，如图10.5所示。 作为 UIViewController 的子类，UITableViewController 继承了 view 属性。 当第一次访问此属性时，将调用 loadView() 方法，该方法创建并加载视图对象。 UITableViewController 的视图始终是 UITableView 的一个实例，因此可以用 UITableViewController 的 view 属性来获得明亮，有光泽和空的表视图"
//        }else{
//            (cell as!TwoLabelTableViewCell).label2.text="UITableViewController 的 view 属性来获得明亮，有光泽和空的表视图"
//        }
        
        return cell!
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView=UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.dataSource=self;
        tableView.delegate=self;
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 300
        tableView.estimatedRowHeight = 44.0
        
//        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        tableView.register(UINib(nibName:"TwoLabelTableViewCell", bundle:nil) , forCellReuseIdentifier: "re")
        self.view.addSubview(tableView)
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
