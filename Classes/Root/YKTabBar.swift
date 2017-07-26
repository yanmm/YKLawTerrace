//
//  WEYTabBar.swift
//  WEYBee
//
//  Created by Yuki on 16/6/17.
//  Copyright © 2016年 Zhejiang YaoWang Network Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol YKTabBarDelegate {
    func tabBarBtnClick()
}

class WEYTabBar: UITabBar {
    var tabBarDelegate: YKTabBarDelegate!
    var plusButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let plusBtn = UIButton()
        plusBtn.setImage(UIImage(named: "btn_menu__live_n"), for: UIControlState())
        plusBtn.setImage(UIImage(named: "btn_menu__live_n"), for: UIControlState.highlighted)
        var temp = plusBtn.frame
        temp.size = plusBtn.currentImage!.size
        plusBtn.frame = temp
        plusBtn.addTarget(self, action: #selector(plusClick), for: UIControlEvents.touchUpInside)
        self.addSubview(plusBtn)
        self.plusButton = plusBtn
        self.plusButton.bringSubview(toFront: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func plusClick() {
        self.tabBarDelegate.tabBarBtnClick()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tabbarButtonW = (self.frame.size.width - self.plusButton.frame.size.width) / 2
        
        self.plusButton.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5 - 8)
        
        let imageWidth = (self.frame.size.width - 40) / 2
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: 0.5))
        imageView1.image = UIImage(named: "bg_line_e9e9e9")
        self.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x: imageWidth + 40, y: 0, width: imageWidth, height: 0.5))
        imageView2.image = UIImage(named: "bg_line_e9e9e9")
        self.addSubview(imageView2)
        
        var tabbarButtonIndex = 0
        for child: UIView in self.subviews {
            let Class: AnyClass = NSClassFromString("UITabBarButton")!
            if child.isKind(of: Class) {
                // 设置宽度
                var temp = child.frame
                temp.size.width = tabbarButtonW
                temp.origin.x = tabbarButtonIndex == 0 ? 0 : tabbarButtonW + self.plusButton.frame.size.width
                child.frame = temp
                
                // 增加索引
                tabbarButtonIndex += 1
                if (tabbarButtonIndex == 1) {
                    tabbarButtonIndex += 1
                }
            }
        }
    }
}
