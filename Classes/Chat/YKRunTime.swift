//
//  YKRunTime.swift
//  YKProject
//
//  Created by Yuki on 16/9/27.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class YKRunTime: NSObject,RCIMUserInfoDataSource ,RCIMGroupInfoDataSource {
    public static let shared : YKRunTime = { return  YKRunTime() }()
    
    /// 连接聊天服务器
    func heartBeat() {
        RCIM.shared().connect(withToken: YKUser.shared.IMToken, success: { (userId) -> Void in
                RCIM.shared().userInfoDataSource = self
                RCIM.shared().groupInfoDataSource = self
                NotificationCenter.default.post(name: Notification.Name(rawValue: kConnectIMSuccessNotification), object: nil)
                print("登陆成功。当前登录的用户ID：\(userId)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
    }
    
    /// 开始连接融云
    func toConnect() {
        YKHttpClient.shared.getToken { (data, error) in
            if let data = data {
                YKUser.shared.IMToken = data.token
                YKUser.shared.IMUserID = data.userId
                self.heartBeat()
            }
        }
    }
    
    /// 程序退出时调用该方法
    func toDisable() {
        RCIM.shared().disconnect()
        RCIM.shared().clearUserInfoCache()
        RCIM.shared().clearGroupInfoCache()
    }
    
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        YKHttpClient.shared.userinfo(userId) { (data, error) in
            if let data = data {
                let info = RCUserInfo(userId: userId, name: data.realname, portrait: data.figure_avatar)
                if userId == String(YKUser.shared.IMUserID) {
                    YKUser.shared.nickname = data.realname
                    YKUser.shared.avatar = data.figure_avatar
                }
                return completion(info)
            }
        }
        return completion(nil)
    }
    
    func getGroupInfo(withGroupId groupId: String!, completion: ((RCGroup?) -> Void)!) {
//        YKHttpClient.shared.getGroupById(groupId) { (data, error) in
//            if let data = data {
//                if data.count > 0 {
//                    let info = RCGroup(groupId: groupId, groupName: data[0].name, portraitUri: "")
//                    return completion(info)
//                } else {
//                    return completion(nil)
//                }
//            }
//        }
        return completion(nil)
    }
}
