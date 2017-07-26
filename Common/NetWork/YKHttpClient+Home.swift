//
//  YKHttpClient+Home.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

extension YKHttpClient {
    /// 获取融云token
    func getToken(_ completionHandler:@escaping (YKIMToken?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/rong/getToken", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let data = responseObject["responseData"] as? NSDictionary {
                    completionHandler(YKIMToken(json: JSON(data)), nil)
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
}
