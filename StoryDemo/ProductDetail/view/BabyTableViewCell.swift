//
//  BabyTableViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/10.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class BabyTableViewCell: UITableViewCell {

    @IBOutlet weak var min_price: UILabel!
    @IBOutlet weak var market_price: UILabel!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var express: UILabel!
    @IBOutlet weak var pin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
