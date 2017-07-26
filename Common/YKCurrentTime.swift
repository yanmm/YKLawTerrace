//
//  YKCurrentTime.swift
//  YKProject
//
//  Created by Yuki on 2016/10/9.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

/// 获取当前时间
func getGurrentTime() -> String {
    let date = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strNowTime = timeFormatter.string(from: date) as String
    return strNowTime
}

/// 获取当天时间（不带年月日）
func getTodayTime() -> String {
    let date = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strNowTime = timeFormatter.string(from: date) as String
    let array: [String] = (strNowTime as NSString).components(separatedBy: " ")
    return array[1] 
}

/// 获取秒数(传入HH:mm:ss)
func getSec(_ time: String) -> Int {
    let array: [String] = (time as NSString).components(separatedBy: ":")
    let hour = Int(array[0])! * 3600
    let min = Int(array[1])! * 60
    let sec = Int(array[2])
    return hour + min + sec!
}

/// 获取当前年
func getCurrentYear() -> Int {
    let calendar = Calendar.current
    let com = (calendar as NSCalendar).components([.year,.month,.day], from:Date())
    return com.year!
}

/// 获取当前月
func getCurrentMonth() -> Int {
    let calendar = Calendar.current
    let com = (calendar as NSCalendar).components([.year,.month,.day], from:Date())
    return com.month!
}

/// 获取当前日
func getCurrentDay() -> Int {
    let calendar = Calendar.current
    let com = (calendar as NSCalendar).components([.year,.month,.day], from:Date())
    return com.day!
}

/// 时间戳转字符串
func IntToString(_ time: Int) -> String {
    //转换为时间
    let timeInterval: TimeInterval = TimeInterval(time)
    let date = Date(timeIntervalSince1970: timeInterval)
    
    //格式话输出
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd"
    
    return dformatter.string(from: date)
}

/// 获取手机型号
public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

/// 判断手机号
func isTelNumber(_ num: NSString) -> Bool {
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true)) {
        return true
    } else {
        return false
    }
}

/// 粗略判断身份证
func isIdentityCard(_ card: NSString) -> Bool {
    if card.length < 0 {
        return false
    }
    let regex2 = "^(\\d{14}|\\d{17})(\\d|[xX])$"
    let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex2)
    if identityCardPredicate.evaluate(with: card) == true {
        return true
    }
    return false
}

/// 16进制转10进制
func hex2dec(_ num: String) -> Int {
    let num = (num as NSString).substring(from: 2) as String
    let str = num.uppercased()
    var sum = 0
    for i in str.utf8 {
        sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
        if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
            sum -= 7
        }
    }
    return sum
}
