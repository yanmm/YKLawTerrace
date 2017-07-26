//
//  YKPasswordController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class YKPasswordController: YKBaseTableViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var psdTextField: UITextField!
    @IBOutlet weak var sureTextField: UITextField!
    @IBOutlet weak var okBtn: IBDesignableButton!
    @IBOutlet weak var codeBtn: UIButton!
    var timer: Timer?
    var sec = 0 // 秒数
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    /// 初始化视图
    func initView() {
        tableView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tableView.addGestureRecognizer(tap)
        phoneTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        codeTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        psdTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        sureTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        okBtn.isEnabled = false
        okBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
    }
    
    /// 倒计时
    func timeRun() {
        self.sec = self.sec - 1
        if self.sec == 0 {
            self.codeBtn.setTitle("获取验证码", for: UIControlState())
            self.codeBtn.setTitleColor(UIColor(hex6: 0x54ACEB), for: UIControlState())
            self.timer?.invalidate()
            self.codeBtn.isEnabled = true
            return
        }
        self.codeBtn.isEnabled = false
        self.codeBtn.titleLabel?.text = "\(self.sec)" + "s"
        self.codeBtn.setTitle("\(self.sec)" + "s", for: UIControlState())
        self.codeBtn.setTitleColor(UIColor(hex6: 0x999999), for: UIControlState())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideKeyBoard()
        self.timer?.invalidate()
    }
    
    @IBAction func sendCode(_ sender: UIButton) {
        if phoneTextField.text?.characters.count == 0 {
            YKProgressHUD.popupError("请先填写手机号")
            return
        }
        if !isTelNumber(phoneTextField.text! as NSString) {
            YKProgressHUD.popupError("请输入正确的手机号")
            return
        }
        
        YKHttpClient.shared.verifyCode(phoneTextField.text!, type: 2) { (error) in
            if error == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timeRun), userInfo: nil, repeats: true)
                self.sec = 120
                self.codeBtn.isEnabled = false
                
                self.codeBtn.titleLabel?.text = "\(self.sec)" + "s"
                self.codeBtn.setTitle("\(self.sec)" + "s", for: UIControlState())
                self.codeBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
            } else {
                self.showAlert(error: error)
            }
        }
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        if psdTextField.text != sureTextField.text {
            YKProgressHUD.popupError("两次输入的密码不一致")
            return
        }
        if let mobile = phoneTextField.text, let code = codeTextField.text, let password = psdTextField.text, let sure = sureTextField.text {
            YKHttpClient.shared.forgotPwd(mobile, verifyCode: code, password: password, confPassword: sure, completionHandler: { (error) in
                if error == nil {
                    YKProgressHUD.popupSuccess("修改成功")
                    let delay = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    /// 检测textField
    func checkTextField() {
        if phoneTextField.text?.characters.count != 0 &&
            codeTextField.text?.characters.count != 0 &&
            psdTextField.text?.characters.count != 0 &&
            sureTextField.text?.characters.count != 0 {
            okBtn.isEnabled = true
            okBtn.backgroundColor = UIColor(hex6: 0x54ACEB)
        } else {
            okBtn.isEnabled = false
            okBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
        if codeTextField.text?.characters.count > 6 {
            codeTextField.text = (codeTextField.text! as NSString).substring(to: 6)
        }
        if phoneTextField.text?.characters.count > 11 {
            phoneTextField.text = (phoneTextField.text! as NSString).substring(to: 11)
        }
    }
}
