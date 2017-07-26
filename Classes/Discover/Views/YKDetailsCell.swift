//
//  YKDetailsCell.swift
//  YKProject
//
//  Created by Yuki on 2016/12/27.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKDetailsCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindLSSWSData(_ data: WEYLawfirm) {
        iconImage.sd_setImage(with: URL(string: data.agency_image), placeholderImage: UIImage(named: "Me_defaultHeader"))
        nameLabel.text = data.agency_name
        phoneLabel.text = data.contact
        descLabel.text = data.address
    }
}
