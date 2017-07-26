//
//  YKCallUsController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/16.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKCallUsController: YKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// 拨打客服电话
    @IBAction func takePhone(_ sender: UIButton) {
        let url1 = URL(string: "tel://0776-2869776")
        UIApplication.shared.openURL(url1!)
    }
}
