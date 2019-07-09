//
//  CategoryViewController.swift
//  StoryDemo
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDataSource,UICollectionViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var loadDataSuccess:Bool = false
    var cateList = [Category]()
    var rightList = [Category]()
    @IBOutlet weak var search_view: UIView!
    var left_view:UITableView!
    var right_view:UICollectionView!
    var selectIndex:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        search_view.layer.cornerRadius=5
        initLeftTable()
        initRightCollec()
        loaddata()
        // Do any additional setup after loading the view.
    }

    func initLeftTable(){
        left_view=UITableView(frame: CGRect(x: 0, y: 60, width: screenW/3, height: screenH-60),style:.plain)
        
        left_view.rowHeight = UITableViewAutomaticDimension
        left_view.estimatedRowHeight = 40
        left_view.dataSource=self
        left_view.delegate=self
        left_view.backgroundColor=UIColor.lightGray
        left_view.separatorStyle=UITableViewCellSeparatorStyle.none
        left_view.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        left_view.contentInset=UIEdgeInsetsMake(0, 0, 0, 0)
        left_view.register(UINib (nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: "re")
        
        self.view.addSubview(left_view)
    }
    func initRightCollec(){
        let layout = UICollectionViewFlowLayout()
        right_view=UICollectionView(frame: CGRect(x: screenW/3, y: 60, width: screenW/3*2, height: screenH-60),collectionViewLayout: layout)
        right_view.dataSource=self
        right_view.delegate=self
        right_view.backgroundColor=UIColor.white
        right_view.contentInset=UIEdgeInsetsMake(0, 0, 0, 0)
        right_view.register(UINib (nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "right")
        right_view.register(UINib (nibName: "HeadCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
        
        self.view.addSubview(right_view)
    }
    func loaddata(){
        var d = ["app_key":app_key,
                 "timestamp":getTimestamp()
            ] as [String : String]
        let sign=SignTopRequest(params: d)
        d["sign"]=sign
        AlamofireHelper.get(url: cate_all, parameters: d, successHandler: {[weak self](res)in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = true
            let cateRes=CategoryResult.init(json: res)
            ss.cateList=cateRes.Categorys
            ss.left_view.reloadData()
        }){[weak self] (error) in
            HUD.dismiss()
            guard let ss = self else {return}
            ss.loadDataSuccess = false
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - 4*padding
        
        return CGSize(width: collectionViewSize/3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 20, 0, 20)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rightList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rightList[section].SubCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:HeadCollectionReusableView!
        
        //分区头
        if kind == UICollectionElementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: "head", for: indexPath)as!HeadCollectionReusableView
            //设置头部标题
            reusableview.title.text=rightList[indexPath.section].Name
        }
            //分区尾
//        else if kind == UICollectionElementKindSectionFooter{
//            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                           withReuseIdentifier: "FooterView", for: indexPath)
//
//        }
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=right_view.dequeueReusableCell(withReuseIdentifier: "right", for: indexPath) as!CategoryCollectionViewCell
        let cate=rightList[indexPath.section].SubCategories[indexPath.row]
        let url = URL.init(string: cate.Image!)
        cell.icon.kf.setImage(with: url, placeholder: UIImage (named: "image_loading"), options: nil, progressBlock: nil, completionHandler:nil)
        cell.name.text=cate.Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=left_view.dequeueReusableCell(withIdentifier: "re") as!LeftTableViewCell
        cell.name.text=cateList[indexPath.row].Name
        if selectIndex==indexPath {
            cell.name.textColor=UIColor.red
            cell.border(color: UIColor.red, width: 2, type: UIBorderSideType.UIBorderSideTypeLeft, cornerRadius: 0)
            cell.border(color: UIColor.gray, width: 0.5, type: UIBorderSideType.UIBorderSideTypeBottom, cornerRadius: 0)
        }else{
            cell.name.textColor=UIColor.black
            cell.border(color: UIColor.gray, width: 0.5, type: UIBorderSideType.UIBorderSideTypeRight, cornerRadius: 0)
            cell.border(color: UIColor.gray, width: 0.5, type: UIBorderSideType.UIBorderSideTypeBottom, cornerRadius: 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex=indexPath
        left_view.reloadData()
        rightList=cateList[indexPath.row].SubCategories
        right_view.reloadData()
        let ind:IndexPath=IndexPath(row: 0, section: 0)
        right_view.scrollToItem(at: ind, at: UICollectionViewScrollPosition.bottom, animated: false)
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
