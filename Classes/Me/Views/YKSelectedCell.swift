//
//  YKSelectedCell.swift
//  YKProject
//
//  Created by Yuki on 2016/12/14.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKSelectedCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKSelectedModel) {
        titleLabel.text = data.title
        chooseImage.isHidden = !data.isChoose
    }
}
