//
//  YKDynamicDetailCell.swift
//  YKProject
//
//  Created by Yuki on 2017/1/7.
//  Copyright © 2017年 Yuki. All rights reserved.
//

import UIKit

class YKDynamicDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: WEYNewsList) {
        titleLabel.text = data.title
        timeLabel.text = IntToString(data.create_time)
        textView.text = data.content
    }
}
