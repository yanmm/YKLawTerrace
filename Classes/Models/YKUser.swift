//
//  YKUser.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class YKUser {
    public static let shared : YKUser = { return  YKUser() }()
    lazy var userQueue: DispatchQueue = DispatchQueue(label: "com.yallalive.user")
    
    var userid: Int = 0                 { didSet { cacheUser() } }
    var token: String = ""              { didSet { cacheUser() } }
    var avatar: String = ""             { didSet { cacheUser() } }
    var nickname: String = ""           { didSet { cacheUser() } }
    var IMToken: String = ""            { didSet { cacheUser() } }
    var IMUserID: Int = 0               { didSet { cacheUser() } }
    
    var isLogin: Bool {
        get { return token.characters.count > 0 }
    }
    
    fileprivate func cacheUser() {
        if isLogin {
            userQueue.async {
                let userInfoDict = ["userid": self.userid,
                                    "token": self.token,
                                    "nickname": self.nickname,
                                    "avatar": self.avatar,
                                    "IMToken": self.IMToken,
                                    "IMUserID": self.IMUserID] as [String : Any]
                UserDefaults.standard.set(userInfoDict, forKey: kUserInfoCacheKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    /// 初始化个人信息
    func setupUserInfo(_ dict: [String: AnyObject]) {
        let json = JSON(dict)
        
        self.token = json["token"].stringValue
        self.userid = json["userid"].intValue
        self.nickname = json["nickname"].stringValue
        self.avatar = kAPI_HOST_HTTP + json["avatar"].stringValue
    }
    
    /// 重新登录时赋值
    func setUpInfo(_ dict: [String: AnyObject]) {
        let json = JSON(dict)
        
        self.token = json["token"].stringValue
        self.userid = json["userid"].intValue
        self.nickname = json["nickname"].stringValue
        self.avatar = json["avatar"].stringValue
        self.IMToken = json["IMToken"].stringValue
        self.IMUserID = json["IMUserID"].intValue
    }
    
    /// 获取当前信息
    func currentLoginInfo() -> [String: AnyObject]? {
        if let loginInfo = UserDefaults.standard.object(forKey: kUserInfoCacheKey) as? [String: AnyObject] {
            setUpInfo(loginInfo)
            return loginInfo
        }
        return nil
    }
    
    /// 退出登录
    func loginout() {
        // 清空磁盘数据
        UserDefaults.standard.set(nil, forKey: kUserInfoCacheKey)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name(rawValue: kLogoutSuccessNotification), object: nil)
    }
}
