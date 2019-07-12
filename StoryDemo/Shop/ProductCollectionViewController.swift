//
//  ProductCollectionViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/12.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var type: String!
    var pageNo:Int = 1
    var productList = [mGiftListNew]()
    init(type:String) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
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

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func initTable(){
//        let layout = collectionView!.collectionViewLayout as? UICollectionViewFlowLayout
        //layout?.scrollDirection = .horizontal
        //layout?.minimumLineSpacing = 0
//        layout!.estimatedItemSize = CGSize(width: 58, height: 58)
        
        collectionView!.backgroundColor="eeeeee".color()
        collectionView!.register(UINib (nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        //refresh
        let header = TTRefreshHeader.init(refreshingBlock: {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = 1
            strongSelf.collectionView!.mj_footer.state = .idle
            strongSelf.collectionView!.mj_header.endRefreshing()
            strongSelf.loadData()
        })
        
        collectionView!.mj_header = header;
        
        let footer = TTRefreshFooter  {  [weak self] in
            guard let strongSelf = self else{return}
            strongSelf.pageNo = strongSelf.pageNo + 1
            strongSelf.loadData();
        }
        
        collectionView!.mj_footer = footer
        collectionView!.mj_footer.isHidden = true
    }
    func loadData() {
        //HUD.show(withStatus: NSLocalizedString("Loading", comment: ""))
        let d = ["page":String(pageNo)
            ] as [String : String]
        
        AlamofireHelper.post(url: integral_mall, parameters: d, successHandler: {[weak self] (res) in
            HUD.dismiss()
            guard let ss = self else {return}
            
            if ss.pageNo == 1{ ss.productList.removeAll()}
            
            if (ss.collectionView!.mj_header.isRefreshing()){
                ss.collectionView!.mj_header.endRefreshing()
            }else if (ss.collectionView!.mj_footer.isRefreshing()) {
                ss.collectionView!.mj_footer.endRefreshing()
                
            }
            let giftList=mGiftListResult.init(json: res)
            
            if giftList.GiftListNew.count>0 {
                if (ss.collectionView!.mj_footer.isHidden) && giftList.GiftListNew.count > 0 {
                    ss.collectionView!.mj_footer.isHidden = false
                }
                ss.productList.insert(contentsOf: giftList.GiftListNew, at: ss.productList.count)
                if ss.productList.count < 3 {
                    ss.collectionView!.mj_footer.state = .noMoreData
                }
            }else {
                ss.collectionView!.mj_footer.state = .noMoreData
            }
            
            ss.collectionView!.reloadData()
            //print(res);
        }) {[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            if (ss.collectionView!.mj_header.isRefreshing()){ss.collectionView!.mj_header.endRefreshing()}
            else if (ss.collectionView!.mj_footer.isRefreshing()) {ss.collectionView!.mj_footer.endRefreshing()}
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!ProductCollectionViewCell
        
        // Configure the cell
        let product=productList[indexPath.row]
        
        let url = URL.init(string: "\(BASE_URL)\(product.ImagePath!)/1.png")
        cell.icon.kf.setImage(with: url, placeholder: UIImage (named: "image_loading"), options: nil, progressBlock: nil, completionHandler:nil)
        cell.name.text=product.GiftName
        cell.count.text=String(product.NeedIntegral)
        cell.layer.cornerRadius=5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = screenW - 3*padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2+116)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
