/**
 *  @file        UIViewController+Alert.swift
 *  @project     WEYBee
 *  @brief
 *  @author      Lipeng
 *  @date        16/3/23 下午12:00
 *  @version     1.0
 *  @note
 *
 *  Copyright © 2016年 Zhejiang YaoWang Network Technology Co., Ltd. All rights reserved.
 */

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String = "", msg: String?) {
        
        let ok = "确定"
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: ok, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String = "", error: NSError?) {
        if let error = error, self.view.window != nil {
            
            let ok = "确定"
            let alert = UIAlertController(title: title,
                                          message: error.localizedDescription,
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: ok,
                style: UIAlertActionStyle.default,
                handler: { (_) -> Void in
                // 未登录, 账号冻结
                let code = error.localizedDescription
                if code == "账户未登录，请先登录"  {
                    if YKUser.shared.isLogin {
                        YKUser.shared.loginout()
                    }
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(_ title: String?,
                   message: String?,
                   cancel: String?,
                   ok: String = "确定",
                   okBlock: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: nil))
        }
        alert.addAction(UIAlertAction(title: ok, style: UIAlertActionStyle.destructive, handler: { (_) in
            okBlock()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
