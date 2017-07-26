//
//  YKSetingCell.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKSetingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKMeCellModel) {
        titleLabel.text = data.title
    }
}
