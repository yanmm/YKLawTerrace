//
//  YKLoginController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/2.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLoginController: YKBaseTableViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var psdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(gotoRegister))
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tableView.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endEditing()
    }
    
    /// 结束编辑
    func endEditing() {
        phoneTextField.resignFirstResponder()
        psdTextField.resignFirstResponder()
    }
    
    /// 注册
    func gotoRegister() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterID") as! YKRegisterController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 手机登录
    @IBAction func login(_ sender: UIButton) {
        endEditing()
        if phoneTextField.text?.characters.count == 0 {
            YKProgressHUD.popupError("请输入帐号")
            return
        }
        if !isTelNumber(phoneTextField.text! as NSString) {
            YKProgressHUD.popupError("请输入正确的手机号")
            return
        }
        if psdTextField.text?.characters.count == 0 {
            YKProgressHUD.popupError("请输入密码")
            return
        }
        YKHttpClient.shared.login(phoneTextField.text!, password: psdTextField.text!) { (error) in
            if error == nil {
                NotificationCenter.default.post(name: Notification.Name(rawValue: kLoginSuccessNotification), object: nil)
            } else {
                self.showAlert(error: error)
            }
        }
    }
    
    /// 忘记密码
    @IBAction func forgetPsd(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordID") as! YKPasswordController
        vc.title = "找回密码"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
