//
//  EvaluateTableViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/10.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class EvaluateTableViewCell: UITableViewCell {

    @IBOutlet weak var shop_icon: UIImageView!
    @IBOutlet weak var shop_name: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var baby_count: UILabel!
    @IBOutlet weak var baby_desc: UILabel!
    @IBOutlet weak var shop_service: UILabel!
    @IBOutlet weak var express_service: UILabel!
    @IBOutlet weak var all_baby_btn: UILabel!
    @IBOutlet weak var into_shop_btn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
