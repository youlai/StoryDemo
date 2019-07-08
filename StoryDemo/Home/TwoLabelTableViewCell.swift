//
//  TwoLabelTableViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class TwoLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var m: UIImageView!
    @IBOutlet weak var v: UIView!
    @IBOutlet weak var gobuy: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("lala")
                gobuy.border(color: UIColor.red, width: 0.5, type: UIBorderSideType.UIBorderSideTypeAll, cornerRadius: 5)
        gobuy.titleLabel?.font=UIFont.systemFont(ofSize: 14)
        gobuy.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, -10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
