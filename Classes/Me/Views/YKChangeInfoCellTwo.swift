//
//  YKChangeInfoCellTwo.swift
//  YKProject
//
//  Created by Yuki on 2016/12/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKChangeInfoCellTwo: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKChangeInfoModel) {
        titleLabel.text = data.title
        descLabel.text = data.desc
    }
}
