//
//  YKRegisterInfoController.swift
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


class YKRegisterInfoController: YKPhotoTableViewController,MLLinkLabelDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var psdTextField: UITextField!
    @IBOutlet weak var sureTextField: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var okBtn: IBDesignableButton!
    @IBOutlet weak var protolLabel: MLLinkLabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var psdLockBtn: UIButton!
    @IBOutlet weak var sureLockBtn: UIButton!
    fileprivate var selectedImage: UIImage?
    fileprivate var timer: Timer?
    fileprivate var sec = 0 // 秒数
    var type = 0 // 0.平台用户；1.律师；2.法律服务工作者；3.公证员；4.司法局工作员；5.鉴定机构人员；6.人员调解员
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideKeyBoard()
        self.timer?.invalidate()
    }
    
    /// 初始化视图
    func initView() {
        tableView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.delegate = self
        tableView.addGestureRecognizer(tap)
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        iconImage.isUserInteractionEnabled = true
        iconImage.addGestureRecognizer(imgTap)
        phoneTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        codeTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        psdTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        sureTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        okBtn.isEnabled = false
        okBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        
        protolLabel.allowLineBreakInsideLinks = true
        protolLabel.linkTextAttributes = nil
        protolLabel.activeLinkTextAttributes = nil
        protolLabel.delegate = self
        protolLabel.isUserInteractionEnabled = true
        
        let attrStr = NSMutableAttributedString(string: "点击注册，即代表你统同意了《百色市12348公共法律服务平台服务协议》")
        let nicknameRange = NSMakeRange(13, ("点击注册，即代表你统同意了《百色市12348公共法律服务平台服务协议》" as NSString).length - 13)
        attrStr.addAttribute(NSForegroundColorAttributeName,
                             value: UIColor(hex6: 0x8BC6F1),
                             range: nicknameRange)
        attrStr.addAttribute(NSLinkAttributeName, value: "12348", range: nicknameRange)
        protolLabel.attributedText = attrStr
        protolLabel.invalidateDisplayForLinks()
    }
    
    /// 选择头像
    func chooseImage() {
        hideKeyBoard()
        showSheetView()
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
    
    /// 密码可见
    @IBAction func psdLockClick(_ sender: UIButton) {
        psdTextField.isSecureTextEntry = !psdTextField.isSecureTextEntry
        if psdTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Login_unlock"), for: UIControlState())
        } else {
            sender.setImage(UIImage(named: "Login_lock"), for: UIControlState())
        }
    }
    
    /// 确认密码可见
    @IBAction func sureLockClick(_ sender: UIButton) {
        sureTextField.isSecureTextEntry = !sureTextField.isSecureTextEntry
        if sureTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Login_unlock"), for: UIControlState())
        } else {
            sender.setImage(UIImage(named: "Login_lock"), for: UIControlState())
        }
    }
    
    @IBAction func sendCode(_ sender: UIButton) {
        if phoneTextField.text?.characters.count == 0 {
            YKProgressHUD.showError("请先填写手机号")
            return
        }
        if !isTelNumber(phoneTextField.text! as NSString) {
            YKProgressHUD.showError("请输入正确的手机号")
            return
        }
        
        if let phone = phoneTextField.text {
            YKHttpClient.shared.verifyCode(phone, type: 1, completionHandler: { (error) in
                if error == nil {
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timeRun), userInfo: nil, repeats: true)
                    self.sec = 120
                    self.codeBtn.isEnabled = false
                    
                    self.codeBtn.titleLabel?.text = "\(self.sec)" + "s"
                    self.codeBtn.setTitle("\(self.sec)" + "s", for: UIControlState())
                    self.codeBtn.setTitleColor(UIColor(hex6: 0x999999), for: UIControlState())
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        hideKeyBoard()
        if psdTextField.text != sureTextField.text {
            YKProgressHUD.showError("两次输入的密码不一致")
            return
        }
        if let mobile = phoneTextField.text, let code = codeTextField.text, let password = psdTextField.text, let sure = sureTextField.text {
            YKHttpClient.shared.reg(mobile, type: type, verifyCode: code, password: password, confPassword: sure, image: selectedImage, completionHandler: { (error) in
                if error == nil {
                    if self.type == 0 {
                        YKHttpClient.shared.login(mobile, password: password, completionHandler: { (error) in
                            if error == nil {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: kLoginSuccessNotification), object: nil)
                            } else {
                                self.showAlert(error: error)
                            }
                        })
                    } else {
                        YKProgressHUD.showSuccess("提交成功，等待管理员审核...")
                        let time: TimeInterval = kDelayTime_Of_HUD
                        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
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
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.iconImage.image = image
            self.selectedImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// MLLinkLabelDelegate
    func didClick(_ link: MLLink!, linkText: String!, linkLabel: MLLinkLabel!) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProtolID") as! YKProtolController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(NSStringFromClass((touch.view?.classForCoder)!))
        if NSStringFromClass((touch.view?.classForCoder)!) == "MLLinkLabel" {
            return false
        }
        return true
    }
}
