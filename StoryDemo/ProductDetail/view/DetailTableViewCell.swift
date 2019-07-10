//
//  DetailTableViewCell.swift
//  StoryDemo
//
//  Created by mac on 2019/7/10.
//  Copyright © 2019年 zhkj. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var webview: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
