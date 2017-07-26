//
//  WEYNoDataView.swift
//  WEYBee
//
//  Created by Yuki on 16/4/7.
//  Copyright © 2016年 Zhejiang YaoWang Network Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol YKNoDataViewDelegate: NSObjectProtocol {
    func goBtnClick()
}

class YKNoDataView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var goBtn: UIButton!
    weak var delegate: YKNoDataViewDelegate?

    class func show(_ message: String?, btnTitle: String?) -> YKNoDataView {
        let view = Bundle.main.loadNibNamed("YKNoDataView", owner: self, options: nil)!.first as! YKNoDataView
        view.bindData(message, btnTitle: btnTitle)
        return view
    }
    
     fileprivate func bindData(_ message: String?, btnTitle: String?) {
        if btnTitle == nil {
            goBtn.isHidden = true
        } else {
            goBtn.isHidden = false
            goBtn.setTitle(btnTitle, for: UIControlState())
        }
        messageLabel.text = message
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        self.delegate?.goBtnClick()
    }
}
