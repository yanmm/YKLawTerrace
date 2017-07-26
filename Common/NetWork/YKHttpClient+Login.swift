//
//  YKHttpClient+Login.swift
//  QEMShop
//
//  Created by Yuki on 16/8/5.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation
import UIKit

extension YKHttpClient {
    /// 用户登录
    func login(_ cellphone: String, password: String, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["cellphone": cellphone,
                          "password": password]
        _ = YKPOST("/api/user/login", parameters: parameters, success: { (_, responseObject) -> Void in
            if let responseObject = responseObject as? [String : AnyObject] {
                YKUser.shared.setupUserInfo(responseObject["responseData"] as! [String : AnyObject])
            }
            completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 获取验证码 type 1:注册 2:忘记密码
    func verifyCode(_ cellphone: String, type: Int, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["cellphone": cellphone,
                          "type": type] as [String : Any]
        _ = YKPOST("/api/user/verifyCode", parameters: parameters, progress: nil, success: { (_, responseObject) -> Void in
            completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 注册
    func reg(_ cellphone: String, type: Int, verifyCode: String, password: String, confPassword: String, image: UIImage?, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["cellphone": cellphone,
                          "verifyCode": verifyCode,
                          "type": type,
                          "password": password,
                          "confPassword": confPassword] as [String : Any]
        post("/api/user/reg", parameters: parameters, constructingBodyWith: { (formData) in
            if let image = image {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHHmmss"
                    let fileName = formatter.string(from: Date()) + ".jpg"
                    formData.appendPart(withFileData: imageData, name: "avatar", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            }, progress: nil, success: { (_, responseObject) in
                completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 修改密码
    func forgotPwd(_ cellphone: String, verifyCode: String, password: String, confPassword: String, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["cellphone": cellphone,
                          "verifyCode": verifyCode,
                          "password": password,
                          "confPassword": confPassword]
        _ = YKPOST("/api/user/forgotPwd", parameters: parameters, progress: nil, success: { (_, responseObject) -> Void in
            completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
}
