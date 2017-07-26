//
//  YKLawApplyTwoCell.swift
//  YKProject
//
//  Created by Yuki on 2016/12/14.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyTwoCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: String, indexPath: IndexPath) {
        titleLabel.text = data
        titleLabel.textColor = indexPath.row == 0 ? UIColor(hex6: 0x333333) : UIColor(hex6: 0x666666)
    }
}
