//
//  YKMessageController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/12.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKMessageController: YKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        let vc = YKChatListController(nibName: nil, bundle: nil)
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

}
