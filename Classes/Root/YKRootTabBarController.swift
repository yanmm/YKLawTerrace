//
//  YKRootTabBarController.swift
//  WEYBee
//
//  Created by Yuki on 16/6/17.
//  Copyright © 2016年 Zhejiang YaoWang Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class YKRootTabBarController: UITabBarController,YKTabBarDelegate,RCIMReceiveMessageDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
        self.addAllChildVcs()
//        self.addCustomTabBar()
        
        self.tabBar.backgroundImage = UIImage(named: "bg_menu_me")
        self.tabBar.shadowImage = UIImage(named: "bg_line_e9e9e9")
        self.tabBar.tintColor = UIColor(hex6: 0xE62129)
        
        YKRunTime.shared.toConnect()
        NotificationCenter.default.addObserver(self, selector: #selector(connectIMSuccess), name: NSNotification.Name(rawValue: kConnectIMSuccessNotification), object: nil)
    }
    
    /// 成功链接融云
    func connectIMSuccess() {
        RCIM.shared().enableMessageRecall = true
        RCIM.shared().enableTypingStatus = true
        RCIM.shared().receiveMessageDelegate = self
    }
    
    func addCustomTabBar() {
        //创建自定义tabbar
        let customTabBar = WEYTabBar()
        customTabBar.tabBarDelegate = self
        
        //更换系统自带的tabbar
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    func addAllChildVcs() {
        let homeVC = UIStoryboard(name: "YKHome", bundle: nil).instantiateInitialViewController()!
        let categoryVC = UIStoryboard(name: "YKDiscover", bundle: nil).instantiateInitialViewController()!
        let judgeVC = UIStoryboard(name: "YKMessage", bundle: nil).instantiateInitialViewController()!
        let cartVC = UIStoryboard(name: "YKDynamic", bundle: nil).instantiateInitialViewController()!
        let meVC = UIStoryboard(name: "YKMe", bundle: nil).instantiateInitialViewController()!
        
        self.addChildVC(homeVC, imageName: "Home", SelectImageName: "", title: "首页", enabled: true)
        self.addChildVC(categoryVC, imageName: "Discover", SelectImageName: "", title: "附近", enabled: true)
        self.addChildVC(judgeVC, imageName: "Message", SelectImageName: "", title: "消息", enabled: true)
        self.addChildVC(cartVC, imageName: "Dynamic", SelectImageName: "", title: "动态", enabled: true)
        self.addChildVC(meVC, imageName: "Me", SelectImageName: "", title: "我的", enabled: true)
    }
    
    func addChildVC(_ childVC: UIViewController, imageName: String?, SelectImageName: String?, title: String?, enabled: Bool) {
        if let imageName = imageName {
            childVC.tabBarItem.image = UIImage(named: imageName)
        }
        if let SelectImageName = SelectImageName {
            childVC.tabBarItem.selectedImage = UIImage(named: SelectImageName)
        }
        childVC.tabBarItem.isEnabled = enabled
        childVC.tabBarItem.title = title
        childVC.title = title
//        childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        childVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        self.addChildViewController(childVC)
    }
    
    func tabBarBtnClick() {
        
    }
    
    /// RCIMReceiveMessageDelegate
    
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        
    }
    
    func onRCIMCustomAlertSound(_ message: RCMessage!) -> Bool {
        return false
    }
    
    func onRCIMCustomLocalNotification(_ message: RCMessage!, withSenderName senderName: String!) -> Bool {
        return false
    }
}
