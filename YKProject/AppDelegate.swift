//
//  AppDelegate.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {//,BMKGeneralDelegate {

    var window: UIWindow?
    // 默认是false保证第一次如果有推送消息进入可以执行有后台通知的判断
    var isBecomeActive = false
//    var mapManager: BMKMapManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 2.0)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setupRootController()
        self.window?.makeKeyAndVisible()
        
        self.initAppSettings()
        
        // 融云
        RCIM.shared().initWithAppKey("pkfcgjstpwik8")
        
        // 要使用百度地图，请先启动BaiduMapManager
//        mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
//        let ret = mapManager?.start("Q2p7aGqr6Da0mlvI0ypg7r3LY5kZqnkO", generalDelegate: self)
//        if ret == false {
//            NSLog("manager start failed!")
//        }
        
        
        return true
    }
    
    fileprivate func initAppSettings() {
        // 开启网络监听
        AFNetworkReachabilityManager.shared().startMonitoring()
        
        // 注册登录登出通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessNotification),name: NSNotification.Name(rawValue: kLoginSuccessNotification),object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logoutSuccessNotification),name: NSNotification.Name(rawValue: kLogoutSuccessNotification),object: nil)
    }
    
    func setupRootController() {
        if YKUser.shared.currentLoginInfo() == nil {
            logoutSuccessNotification()
        } else {
            loginSuccessNotification()
        }
    }
    
    // MARK: - NSNotificationCenter
    
    func loginSuccessNotification() {
        window?.rootViewController = YKRootTabBarController()
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func logoutSuccessNotification() {
        let storyboard = UIStoryboard(name: "YKLogin", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    //    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    //        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    //    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(YKUtils.deviceID())
    }
    
    // 8.0 之后 收到远程推送通知
    func application(_ application: UIApplication , didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping ( UIBackgroundFetchResult ) -> Void ) {
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //到后台变成false
        isBecomeActive = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //进入应用就会调用此方法，如果有通知消息在通知的方法之后执行
        isBecomeActive = true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if iError == 0 {
            print("联网成功")
        } else {
            print("联网失败，错误代码：Error\(iError)")
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if iError == 0 {
            print("授权成功")
        }
        else{
            print("授权失败，错误代码：Error\(iError)")
        }
    }
}

