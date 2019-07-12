//
//  TableViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/11.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var type: String!
    var pageNo:Int = 1
    var pageSize:Int = 10
    var loadDataSuccess:Bool = false
    var productList = [Products]()
    init(type:String) {
        super.init(nibName: nil, bundle: nil)
        self.type=type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func initTable(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 900
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorStyle = .none
        tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.register(UINib (nibName: "TwoLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "re")
        
        //refresh
        let header = TTRefreshHeader.init(refreshingBlock: {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = 1
            strongSelf.tableView.mj_footer.state = .idle
            strongSelf.tableView.mj_header.endRefreshing()
            strongSelf.loadData()
        })
        
        tableView.mj_header = header;
        
        let footer = TTRefreshFooter  {  [weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = strongSelf.pageNo + 1
            strongSelf.loadData();
        }
        
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
    }
    func loadData() {
        //HUD.show(withStatus: NSLocalizedString("Loading", comment: ""))
        var d = ["pageNo":String(pageNo),
                 "pageSize":String(pageSize),
                 "app_key":app_key,
                 "timestamp":getTimestamp()
            ] as [String : String]
        let sign=SignTopRequest(params: d)
        d["sign"]=sign
        
        AlamofireHelper.get(url: home_list_url, parameters: d, successHandler: {[weak self] (res) in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = true
            
            if ss.pageNo == 1{ ss.productList.removeAll()}
            
            if ss.tableView.mj_header.isRefreshing(){
                ss.tableView.mj_header.endRefreshing()
            }else if ss.tableView.mj_footer.isRefreshing() {
                ss.tableView.mj_footer.endRefreshing()
                
            }
            let homeResult=HomeResult.init(json: res)
            
            
            if homeResult.Product.count>0 {
                if ss.tableView.mj_footer.isHidden && homeResult.Product.count > 0 {
                    ss.tableView.mj_footer.isHidden = false
                }
                ss.productList.insert(contentsOf: homeResult.Product, at: ss.productList.count)
                if ss.productList.count < 20 {
                    ss.tableView.mj_footer.state = .noMoreData
                }
            }else {
                ss.tableView.mj_footer.state = .noMoreData
            }
            
            ss.tableView.reloadData()
            //print(res);
        }) {[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = false
            if ss.tableView.mj_header.isRefreshing(){ss.tableView.mj_header.endRefreshing()}
            else if ss.tableView.mj_footer.isRefreshing() {ss.tableView.mj_footer.endRefreshing()}
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "re") as!TwoLabelTableViewCell
        let product=productList[indexPath.row]
        
        let url = URL.init(string: product.ImageUrl!)
        cell.icon.kf.setImage(with: url, placeholder: UIImage (named: "image_loading"), options: nil, progressBlock: nil, completionHandler:nil)
        cell.name.text=product.Name
        cell.price.text="￥"+product.SalePrice!
        cell.oldPrice.text="￥"+product.MarketPrice!
        cell.gobuy.setTitle("去购买", for: .normal)
        return cell
    }

}
