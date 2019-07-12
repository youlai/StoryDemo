//
//  ProductCollectionViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/12.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var buy: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buy.border(color: UIColor.red, width: 0.5, type: UIBorderSideType.UIBorderSideTypeAll, cornerRadius: 2)
        buy.contentEdgeInsets=UIEdgeInsetsMake(5, 5, 5, 5)
    }

}
