//
//  YKRegisterCell.swift
//  YKProject
//
//  Created by Yuki on 2016/11/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

struct YKRegisterModel {
    var title = ""
    var desc = ""
}

class YKRegisterCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKRegisterModel) {
        titleLabel.text = data.title
        descLabel.text = data.desc
    }
}
