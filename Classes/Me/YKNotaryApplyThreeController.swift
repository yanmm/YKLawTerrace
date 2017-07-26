//
//  YKNotaryApplyThreeController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/26.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKNotaryApplyThreeController: YKBaseTableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var referTextView: UITextView!
    @IBOutlet weak var explainTetView: UITextView!
    @IBOutlet weak var nextBtn: IBDesignableButton!
    var notary_id = 0 // 记录ID值

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        nameTextField.leftViewMode = UITextFieldViewMode.always
        nameTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        nameTextField.rightViewMode = UITextFieldViewMode.always
        nameTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        addressTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        addressTextField.leftViewMode = UITextFieldViewMode.always
        addressTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        addressTextField.rightViewMode = UITextFieldViewMode.always
        addressTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        phoneTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        phoneTextField.leftViewMode = UITextFieldViewMode.always
        phoneTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        phoneTextField.rightViewMode = UITextFieldViewMode.always
        phoneTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tableView.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyBoard()
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    /// 检测textField
    func checkTextField() {
        if nameTextField.text?.characters.count != 0 &&
            addressTextField.text?.characters.count != 0 &&
            phoneTextField.text?.characters.count != 0 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x54ACEB)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }

    @IBAction func nextBtnClick(_ sender: UIButton) {
        hideKeyBoard()
        if referTextView.text.characters.count == 0 {
            YKProgressHUD.popupError("请输入供公证处参考的有关信息")
            return
        }
        if explainTetView.text.characters.count == 0 {
            YKProgressHUD.popupError("请输入需要说明/声明的内容")
            return
        }
        if let name = nameTextField.text, let address = addressTextField.text, let phone = phoneTextField.text {
            YKHttpClient.shared.notaryApplyThree(self.notary_id, refer_translation: referTextView.text, explain_content: explainTetView.text, data: name + "-" + address + "-" + phone, completionHandler: { (error) in
                if error == nil {
                    YKProgressHUD.popupSuccess("申请成功")
                    let time: TimeInterval = kDelayTime_Of_HUD
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
}
