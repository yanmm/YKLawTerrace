//
//  YKHttpClient.swift
//  QEMShop
//
//  Created by Yuki on 16/8/5.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class YKHttpClient: AFHTTPSessionManager {
    /// 单例
    public static let shared: YKHttpClient = {
        let client = YKHttpClient(baseURL: URL(string: kAPI_HOST_HTTP))
        client.responseSerializer.acceptableContentTypes = Set(["application/json", "text/json", "text/javascript", "text/plain", "text/html"])
        // 设置超时时间
        client.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        client.requestSerializer.timeoutInterval = 10.0
        client.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        // 回调的线程队列
        client.completionQueue = DispatchQueue(label: "com.yallalive.httpclient")
        return client
    }()
    
    // MARK: - 错误解析
    func Error(for msg: String) -> NSError {
        return NSError(domain: "HttpDomain", code: -1001, userInfo: [NSLocalizedDescriptionKey: msg])
    }
    
    func Error(for msg: String, failureReaon: String) -> NSError {
        let userinfo = [NSLocalizedDescriptionKey: msg, NSLocalizedFailureReasonErrorKey: failureReaon]
        return NSError(domain: "HttpDomain", code: -1001, userInfo: userinfo)
    }
    
    fileprivate func checkResponseData(_ responseObject: Any?) -> NSError? {
        if let json = responseObject as? [String: AnyObject] {
            let new = JSON(json)
            let msg: String = new["msg"].stringValue
                if msg == "success" {
                    return nil
                }
                
                let msgStr = new["msg"].stringValue
                let code = new["code"].intValue
                let error =  NSError(domain: "HttpDomain",
                                     code: code,
                                     userInfo: [NSLocalizedDescriptionKey: msgStr])
                return error
        }
        return Error(for: NSLocalizedString("alert.unknown.error", comment: ""))
    }
    
    override func dataTask(with request: URLRequest, uploadProgress uploadProgressBlock: ((Progress) -> Void)?, downloadProgress downloadProgressBlock: ((Progress) -> Void)?, completionHandler: ((URLResponse, Any?, Error?) -> Void)? = nil) -> URLSessionDataTask {
        
        let Handler:((URLResponse, Any?, Error?) -> Void)? = { (response, responseObject, error) -> Void in
            if error == nil { // 网络请求成功，但服务器操作出错
                if let errorResult = self.checkResponseData(responseObject) {
                    print("failure url:--> \(String(describing: response.url?.absoluteString))")
                    DispatchQueue.main.async {
                        completionHandler?(response, responseObject, errorResult)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler?(response, responseObject, nil)
                    }
                }
            } else { // 错误回调
                print("failure url:--> \(String(describing: response.url?.absoluteString))")
                let localFail = NSLocalizedString("alert.network.error", comment: "")
                let error = self.Error(for: localFail, failureReaon: String(describing: error))
                
                print("failure error.localizedDescription = \(error.localizedDescription)")
                print("failure error.localizedFailureReason = \(String(describing: error.localizedFailureReason))")
                DispatchQueue.main.async {
                    completionHandler?(response, responseObject, error)
                }
            }
        }
        return super.dataTask(with: request, uploadProgress: uploadProgressBlock, downloadProgress: downloadProgressBlock, completionHandler: Handler )
    }
}

extension YKHttpClient {
    
    func YKGET(_ URLString: String,
                  parameters: Any?,
                  progress: ((Progress) -> Void)? = nil,
                  success: ((URLSessionDataTask, Any?) -> Void)?,
                  failure: ((URLSessionDataTask?, Error) -> Void)?) -> URLSessionDataTask?{
        return get(URLString, parameters: parameters, progress: progress, success: success, failure: failure)
    }
    
    func YKPOST(_ URLString: String,
                   parameters: Any?,
                   progress: ((Progress) -> Void)? = nil,
                   success: ((URLSessionDataTask, Any?) -> Void)?,
                   failure: ((URLSessionDataTask?, Error) -> Void)?) -> URLSessionDataTask?{
        return post(URLString, parameters: parameters, progress: progress, success: success, failure: failure)
    }
}
