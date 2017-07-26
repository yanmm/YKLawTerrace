//
//  YKDiscoverCell.swift
//  YKProject
//
//  Created by Yuki on 2016/11/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

struct YKDiscoverModel {
    var image = ""
    var title = ""
}

class YKDiscoverCell: UICollectionViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func bindData(_ data: YKDiscoverModel) {
        iconImage.image = UIImage(named: data.image)
        titleLabel.text = data.title
    }
}
