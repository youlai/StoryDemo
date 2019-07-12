//
//  MineViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tableview:UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as!MineTableViewCell
        cell.selectionStyle = .none
        cell.one_view.layer.cornerRadius=5
        cell.two_view.layer.cornerRadius=5
        cell.three_view.layer.cornerRadius=5
        cell.four_view.layer.cornerRadius=5
        cell.five_view.layer.cornerRadius=30
        cell.avator.layer.cornerRadius=40
        return cell
    }
    func initTable(){
        tableview=UITableView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH),style:.plain)
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = screenW
        tableview.dataSource=self
        tableview.delegate=self
//        tableview.separatorStyle = .none
        tableview.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        tableview.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0)
        tableview.register(UINib (nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "re")
        
        //refresh
        let header = TTRefreshHeader.init(refreshingBlock: {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.tableview.mj_header.endRefreshing()
            strongSelf.loadData()
        })
        
        tableview.mj_header = header;
        
        self.view.addSubview(tableview)
    }
    func loadData(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
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
