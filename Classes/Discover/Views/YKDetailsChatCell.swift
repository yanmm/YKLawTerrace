//
//  YKDetailsChatCell.swift
//  YKProject
//
//  Created by Yuki on 2016/12/27.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKDetailsChatCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindData(_ data: WEYLawers) {
        iconImage.sd_setImage(with: URL(string: data.figure_avatar), placeholderImage: UIImage(named: "Me_defaultHeader"))
        nameLabel.text = data.realname
        phoneLabel.text = data.agency_name
        descLabel.text = "擅长：" + data.engage_service
    }
}
