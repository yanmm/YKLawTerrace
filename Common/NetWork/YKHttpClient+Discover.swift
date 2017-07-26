//
//  YKHttpClient+Discover.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

extension YKHttpClient {
    /// 律师事务所列表
    func lawfirm(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/lawfirm", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["lawfirm"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 律师列表
    func lawer(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawers]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/lawer", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["lawers"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawers(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 公证处列表
    func notary(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/notary", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["notary"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 公证员列表
    func notaryer(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawers]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/notaryer", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["notaryer"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawers(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 人民调解委员会列表
    func committee(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/committee", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["committee"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 司法行政机构列表
    func judicial(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/judicial", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["judicial"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 司法鉴定机构列表
    func identify(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/identify", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["identify"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 基层法律服务所
    func legal(_ addr: String, page: Int, completionHandler:@escaping ([WEYLawfirm]?, NSError?) -> Void) {
        let parameters = ["addr": addr,
                          "page": page] as [String : Any]
        post("/api/search/legal", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let responseData = responseObject["responseData"] as? NSDictionary {
                    if let lawfirm = responseData["legal"] as? [AnyObject] {
                        let dataArray = lawfirm.map({
                            WEYLawfirm(json: JSON($0))
                        })
                        completionHandler(dataArray,nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
}
