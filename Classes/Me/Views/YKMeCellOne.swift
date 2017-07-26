//
//  YKMeCellOne.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKMeCellOne: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKMeCellModel) {
        iconImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "Me_defaultHeader"))
        nameLabel.text = data.title
    }
}
