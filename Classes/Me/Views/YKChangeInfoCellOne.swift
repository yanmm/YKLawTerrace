//
//  YKChangeInfoCellOne.swift
//  YKProject
//
//  Created by Yuki on 2016/12/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKChangeInfoCellOne: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKChangeInfoModel) {
        titleLabel.text = data.title
        iconImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "Me_defaultHeader"))
    }
}
