//
//  HomeViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,WRCycleScrollViewDelegate {

    var pageNo:Int = 1
    let pageSize:Int = 20
    var loadDataSuccess:Bool = false
    var productList = [Products]()
    var limitList=[Lists]()
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var codeView: UIImageView!
    @IBOutlet weak var msgView: UIImageView!
    
    var cycleScrollView:WRCycleScrollView?
    var limitBuyTableView:UITableView=UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.layer.cornerRadius=5

        initTable()
        initBanner()
        loadlimit()
        loadData()
    }
    
    func initTable(){
        limitBuyTableView=UITableView(frame: CGRect(x: 0, y: 90, width: screenW, height: screenH-90),style:.grouped)
        
        limitBuyTableView.rowHeight = UITableViewAutomaticDimension
        limitBuyTableView.estimatedRowHeight = 900
        limitBuyTableView.dataSource=self
        limitBuyTableView.delegate=self
        limitBuyTableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        limitBuyTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0)
        limitBuyTableView.register(UINib (nibName: "TwoLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "re")
        limitBuyTableView.register(UINib (nibName: "HomeHeaderCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //refresh
        let header = TTRefreshHeader.init(refreshingBlock: {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = 1
            strongSelf.limitBuyTableView.mj_footer.state = .idle
            strongSelf.limitBuyTableView.mj_header.endRefreshing()
                        strongSelf.loadData()
        })
        
        limitBuyTableView.mj_header = header;
        
        let footer = TTRefreshFooter  {  [weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = strongSelf.pageNo + 1
                        strongSelf.loadData();
        }
        
        limitBuyTableView.mj_footer = footer
        limitBuyTableView.mj_footer.isHidden = true
        
        self.view.addSubview(limitBuyTableView)
    }
    
    func initBanner(){
        
        let height = screenW / 3
        let frame = CGRect(x: 0, y: 0, width: screenW, height: height)
        // 可加载网络图片或者本地图片
        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",              "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",                  "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        // 构造方法
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages)
        // 添加代理
        cycleScrollView?.delegate = self
    }
    
    func loadlimit(){
        var d = ["pageNo":"1",
                 "pageSize":String(pageSize),
                 "app_key":app_key,
                 "timestamp":getTimestamp()
            ] as [String : String]
        let sign=SignTopRequest(params: d)
        d["sign"]=sign
        AlamofireHelper.get(url: home_limit, parameters: d, successHandler: {[weak self](res)in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = true
            let limitBuyResult=LimitBuyResult.init(json: res)
            ss.limitList=limitBuyResult.List
            ss.limitBuyTableView.reloadData()
        }){[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = false
            if ss.limitBuyTableView.mj_header.isRefreshing(){ss.limitBuyTableView.mj_header.endRefreshing()}
            else if ss.limitBuyTableView.mj_footer.isRefreshing() {ss.limitBuyTableView.mj_footer.endRefreshing()}
        }
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
            
            if ss.limitBuyTableView.mj_header.isRefreshing(){
                ss.limitBuyTableView.mj_header.endRefreshing()
            }else if ss.limitBuyTableView.mj_footer.isRefreshing() {
                ss.limitBuyTableView.mj_footer.endRefreshing()
                
            }
            let homeResult=HomeResult.init(json: res)
            
            
            if homeResult.Product.count>0 {
                if ss.limitBuyTableView.mj_footer.isHidden && homeResult.Product.count > 0 {
                    ss.limitBuyTableView.mj_footer.isHidden = false
                }
                ss.productList.insert(contentsOf: homeResult.Product, at: ss.productList.count)
                if ss.productList.count < 20 {
                    ss.limitBuyTableView.mj_footer.state = .noMoreData
                }
            }else {
                ss.limitBuyTableView.mj_footer.state = .noMoreData
            }
            
            ss.limitBuyTableView.reloadData()
            //print(res);
        }) {[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = false
            if ss.limitBuyTableView.mj_header.isRefreshing(){ss.limitBuyTableView.mj_header.endRefreshing()}
            else if ss.limitBuyTableView.mj_footer.isRefreshing() {ss.limitBuyTableView.mj_footer.endRefreshing()}
        }
    }
    
    /// 点击图片事件
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("点击了第\(index+1)个图片")
    }
    
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("滚动到了第\(index+1)个图片")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section==0 ? screenW/3 : 70
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            initBanner()
            return cycleScrollView
        case 1:
             let img1 = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: 70))
                img1.image=UIImage(named: "home_banner_top")
            return img1
        default:
            let img2 = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: 70))
                img2.image=UIImage(named: "renqi")
            return img2
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return limitList.count
        default:
            return productList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell!
        case 1:
            let cell=tableView.dequeueReusableCell(withIdentifier: "re") as!TwoLabelTableViewCell
            let product=limitList[indexPath.row]
            
            let url = URL.init(string: product.ProductImg!)
            cell.icon.kf.setImage(with: url, placeholder: UIImage (named: "image_loading"), options: nil, progressBlock: nil, completionHandler:nil)
            cell.name.text=product.ProductName
            cell.price.text="￥\(product.MinPrice)"
            cell.oldPrice.text="￥\(product.MarketPrice)"
            return cell
        default:
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 1:
            let pid = String(limitList[indexPath.row].ProductId)
            self.navigationController?.pushViewController(ProductDetailViewController(pid: pid), animated: true)
        case 2:
            let pid = productList[indexPath.row].Id
            self.navigationController?.pushViewController(ProductDetailViewController(pid: pid!), animated: true)
        default: break
        }
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
