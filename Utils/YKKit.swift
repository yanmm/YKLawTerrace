//
//  YKKit.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

// MARK: - 服务器地址
public let kAPI_HOST_HTTP = "http://fa.hbyuntuo.com"

// MARK: - 通知
public let kLoginSuccessNotification  = "kLoginSuccessNotification"
public let kLogoutSuccessNotification = "kLogoutSuccessNotification"

// MARK: - 修改个人信息
public let kChangeInfoNotification  = "kChangeInfoNotification"

// MARK: - 链接融云成功通知
public let kConnectIMSuccessNotification  = "kConnectIMSuccessNotification"

// MARK: - HUD延迟时间
public let kDelayTime_Of_HUD: TimeInterval = 1.2
public let kDurationTime_Of_Animate: TimeInterval = 0.3

// MARK: - 设备标识符操作
public let kDeviceIdentifierKeychainService = "com.YKProject.service"
public let kDeviceIdentifierKeychainAccount = "com.YKProject.account"

// MARK: - 背景颜色值
public let kBackgroundColor: UInt32 = 0x54ACEB

// MARK: - 键
public let kUserInfoCacheKey = "kUserInfoCacheKey"

/// 手机屏幕宽
public let kScreenWidth  = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height

/// 缓存文件夹名
public let kCachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
