//
//  YKHttpClient+Work.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

extension YKHttpClient {
    /// 工作动态
    func dynamic(_ page: Int, completionHandler:@escaping ([WEYNewsList]?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid,
                          "page": page] as [String : Any]
        post("/api/news/dynamic", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let dataArrayFromResponse = responseData["list"] as? [AnyObject] {
                        let dataArray = dataArrayFromResponse.map({
                            WEYNewsList(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 办事指南
    func guide(_ page: Int, completionHandler:@escaping ([WEYNewsList]?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid,
                          "page": page] as [String : Any]
        post("/api/news/guide", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let dataArrayFromResponse = responseData["list"] as? [AnyObject] {
                        let dataArray = dataArrayFromResponse.map({
                            WEYNewsList(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律法规
    func statute(_ page: Int, completionHandler:@escaping ([WEYNewsList]?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid,
                          "page": page] as [String : Any]
        post("/api/news/statute", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let dataArrayFromResponse = responseData["list"] as? [AnyObject] {
                        let dataArray = dataArrayFromResponse.map({
                            WEYNewsList(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律宣传
    func legal(_ page: Int, completionHandler:@escaping ([WEYNewsList]?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid,
                          "page": page] as [String : Any]
        post("/api/news/legal", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let dataArrayFromResponse = responseData["list"] as? [AnyObject] {
                        let dataArray = dataArrayFromResponse.map({
                            WEYNewsList(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 新闻详情
    func detail(_ id: Int, completionHandler:@escaping (WEYNewsList?, NSError?) -> Void) {
        let parameters = ["token": YKUser.shared.token,
                          "userid": YKUser.shared.userid,
                          "id": id] as [String : Any]
        post("/api/news/detail", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let data = responseData["news"] as? NSDictionary {
                        completionHandler(WEYNewsList(json: JSON(data)), nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
}
