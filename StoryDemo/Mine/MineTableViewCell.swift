//
//  MineTableViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/11.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var one_view: UIView!
    @IBOutlet weak var two_view: UIView!
    @IBOutlet weak var three_view: UIView!
    @IBOutlet weak var four_view: UIView!
    @IBOutlet weak var avator: UIImageView!
    @IBOutlet weak var five_view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
