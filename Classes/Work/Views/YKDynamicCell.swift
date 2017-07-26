//
//  YKDynamicCell.swift
//  YKProject
//
//  Created by Yuki on 2016/11/12.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKDynamicCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: WEYNewsList) {
        titleLabel.text = data.title
        descLabel.text = IntToString(data.create_time)
    }
}
