//
//  YKUtils.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

/// 工具类
class YKUtils {
    /// formSheet视图的状态栏风格
    static var formSheetStatusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default
    
    //    /// 是否模拟器平台
    //    static let isSimulator: Bool = {
    //        var flag = false
    //        #if arch(i386) || arch(x86_64)
    //            flag = true
    //        #endif
    //        return flag
    //    }()
    
    /// 设备标识符
    class func deviceID() -> String {
        var error: NSError? = nil
        //    SSKeychain.deletePasswordForService(kDeviceIdentifierService, account: kDeviceIdentifierAccount, error: &error)
        //    return ""
        if let identifier = SSKeychain.password(forService: kDeviceIdentifierKeychainService, account: kDeviceIdentifierKeychainAccount, error: &error) {
            print("设备标识符：\(identifier)")
            
            return identifier
        } else {
            if let error = error {
                print("获取设备标识符失败\(error)")
            }
            
            let uuidstring = YKUtils.UUIDString()
            SSKeychain.setPassword(uuidstring, forService: kDeviceIdentifierKeychainService, account: kDeviceIdentifierKeychainAccount, error: &error)
            
            if let error = error {
                print("设置设备标识符失败\(error)")
            }
            
            return uuidstring
        }
        //SSKeychain.deletePasswordForService(kDeviceIdentifierService, account: kDeviceIdentifierAccount, error: &error)
    }
    
    /// UUID字符串
    class func UUIDString() -> String {
        //        let uuid = CFUUIDCreate(nil) // 创建一个UUID随机码
        //        let uuidstring = CFUUIDCreateString(nil, uuid) as String
        //        return uuidstring
        let uuidStr = UUID().uuidString
        return uuidStr
    }
    
}
