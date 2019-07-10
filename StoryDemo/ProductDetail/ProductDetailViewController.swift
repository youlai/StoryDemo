//
//  ProductDetailViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,WRCycleScrollViewDelegate,UIWebViewDelegate {
    @IBOutlet weak var back_view: UIView!
    @IBOutlet weak var cart_view: UIView!
    @IBOutlet weak var share_view: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var head: UIView!
    var pid:String!
    var product_detail:mProductDetailResult!
    var height:CGFloat!
    init(pid:String) {
        super.init(nibName: nil, bundle: nil)
        self.pid=pid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        back_view.layer.cornerRadius=15
        cart_view.layer.cornerRadius=15
        share_view.layer.cornerRadius=15
        head.backgroundColor=UIColor.clear
        
        tableview.dataSource=self
        tableview.delegate=self
        tableview.estimatedRowHeight=80
        tableview.rowHeight=UITableViewAutomaticDimension
        tableview.separatorStyle=UITableViewCellSeparatorStyle.none
        tableview.register(UINib(nibName: "BabyTableViewCell", bundle: nil), forCellReuseIdentifier: "b")
        tableview.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "d")
        tableview.register(UINib(nibName: "EvaluateTableViewCell", bundle: nil), forCellReuseIdentifier: "e")
        
        //refresh
        let header = TTRefreshHeader.init(refreshingBlock: {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.tableview.mj_header.endRefreshing()
            strongSelf.loaddata()
        })
        tableview.mj_header = header;
        loaddata()
        back_view.addOnClickListener(target: self, action:#selector(back))
    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell=tableview.dequeueReusableCell(withIdentifier: "b")as!BabyTableViewCell
            if (product_detail != nil){
                cell.addSubview(initBanner(imgs: product_detail.Product.ImagePath))
                cell.min_price.text="￥\(product_detail.Product.MinSalePrice)"
                cell.market_price.text="￥\(product_detail.Product.MarketPrice)"
                cell.product_name.text=product_detail.Product.ProductName
                cell.express.text="快递费：\(product_detail.FreightFee)"
                cell.pin.text="月销：\(product_detail.FreightFee)"
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case 1:
            let cell=tableview.dequeueReusableCell(withIdentifier: "e")as!EvaluateTableViewCell
            if (product_detail != nil){
                let url = URL.init(string: product_detail.VShopLog!)
                cell.shop_icon.kf.setImage(with: url, placeholder: UIImage (named: "image_loading"), options: nil, progressBlock: nil, completionHandler:nil)
                cell.shop_name.text=product_detail.Shop.Name
                cell.followers.text="关注人数：\(product_detail.FreightFee)"
                cell.baby_count.text="宝贝数量：\(product_detail.FreightFee)"
                cell.baby_desc.text="宝贝描述：\(product_detail.FreightFee)"
                cell.shop_service.text="卖家服务：\(product_detail.FreightFee)"
                cell.express_service.text="快递服务：\(product_detail.FreightFee)"
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        default:
            let cell=tableview.dequeueReusableCell(withIdentifier: "d")as!DetailTableViewCell
            if (product_detail != nil){
                let html = "<!DOCTYPE html>\n" +
                    "<html lang=\"en\">\n" +
                    "<head>\n" +
                    "\t<meta charset=\"utf-8\">\n" +
                    "\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
                    "\t\n" +
                    "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n" +
                    "\n" +
                    "\t<title>detail</title>\n" +
                    "\n" +
                    "\t<style>body{border:0;padding:0;margin:0;}img{max-width:100%;border:0;display:block;vertical-align: middle;padding:0;margin:0;}p{border:0;padding:0;margin:0;}div{border:0;padding:0;margin:0;}</style>\n" +
                    "</head>"
                    + "<body>\(product_detail.Product.ProductDescription!)</body></html>"
                cell.webview.delegate=self
                cell.webview.loadHTMLString(html, baseURL: nil)
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return height==nil ? 400 : height
        default:
            return UITableViewAutomaticDimension
        }
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if height != nil{
            return
        }
        height=webView.scrollView.contentSize.height
        tableview.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .automatic)
    }
    func initBanner(imgs:[String])->WRCycleScrollView{
        
        let height = screenW
        let frame = CGRect(x: 0, y: 0, width: screenW, height: height)
        // 可加载网络图片或者本地图片
//        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",              "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",                  "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        // 构造方法
        let cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: imgs)
        // 添加代理
        cycleScrollView.delegate = self
        return cycleScrollView
    }
    func loaddata(){
        var d = ["id":pid,
                 //                 "UserKey":"",
            "app_key":app_key,
            "timestamp":getTimestamp()
            ] as [String : String]
        let sign=SignTopRequest(params: d)
        d["sign"]=sign
        AlamofireHelper.get(url: get_product_detail, parameters: d, successHandler: {[weak self](res)in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.product_detail=mProductDetailResult.init(json: res)
            ss.tableview.reloadData()
        }){[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            if ss.tableview.mj_header.isRefreshing(){ss.tableview.mj_header.endRefreshing()}
            else if ss.tableview.mj_footer.isRefreshing() {ss.tableview.mj_footer.endRefreshing()}
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
