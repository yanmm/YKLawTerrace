//
//  YKMeCellTwo.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

struct YKMeCellModel {
    var image = ""
    var title = ""
}

class YKMeCellTwo: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: YKMeCellModel) {
        iconImage.image = UIImage(named: data.image)
        titleLabel.text = data.title
    }
}
