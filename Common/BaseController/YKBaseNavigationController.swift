//
//  YKBaseNavigationController.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    deinit {
        
    }
    
    fileprivate var pan: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor(hex6: kBackgroundColor)
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        //下面两句是去掉UINavigationBar的下边距黑线
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        self.navigationBar.isTranslucent = false
        
        // 设置滑动返回手势
        self.setupPanGestureRecognizer()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if self.viewControllers.count > 0 {
            /* 自动显示和隐藏tabbar */
            viewController.hidesBottomBarWhenPushed = true
            /* 设置导航栏上面的内容 */
            // 设置左边的返回按钮
            let menItem = UIBarButtonItem(image: UIImage(named: "btn_back_ico"), style: UIBarButtonItemStyle.done, target: self, action: #selector(back))
            // 使用弹簧控件缩小菜单按钮和边缘距离
            let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
            spaceItem.width = -10
            viewController.navigationItem.leftBarButtonItems = [spaceItem, menItem]
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() {
        // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
        self.popViewController(animated: true)
    }
    
    // MARK: - Setup PanGestureRecognizer
    
    func setupPanGestureRecognizer() {
        // 获取系统自带滑动手势的target对象
        if let target = self.interactivePopGestureRecognizer?.delegate {
            // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
            let pan = UIPanGestureRecognizer(target: target, action: NSSelectorFromString("handleNavigationTransition:"))
            // 设置手势代理，拦截手势触发
            pan.delegate = self
            // 给导航控制器的view添加全屏滑动手势
            self.view.addGestureRecognizer(pan)
            // 禁止使用系统自带的滑动手势
            self.interactivePopGestureRecognizer?.isEnabled = false
            
            self.pan = pan
        }
    }
    
    func enabledGestureRecognizer(_ enable: Bool) {
        self.pan?.isEnabled = enable
    }
    
    /**
    什么时候调用：每次触发手势之前都会询问下代理，是否触发。
    作用：拦截手势触发
    - parameter gestureRecognizer: 手势识别器
    - returns: 标志是否禁用了当前手势识别器
    */
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
        // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
        if self.viewControllers.count == 1 {
            return false // 表示用户在根控制器界面，就不需要触发滑动手势，
        }
        //金永修改的代码
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
           let translationX = pan.translation(in: self.view).x
            if translationX > 0 {
                return true
            }else {
                return false
            }
        }
    
        return true
    }
}
