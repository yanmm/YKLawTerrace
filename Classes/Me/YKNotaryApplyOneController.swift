//
//  YKNotaryApplyOneController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKNotaryApplyOneController: YKBaseTableViewController,UIGestureRecognizerDelegate {
    @IBOutlet weak var applyNameTextField: UITextField!
    @IBOutlet weak var applySexLabel: UILabel!
    @IBOutlet weak var applyBrithdayLabel: UILabel!
    @IBOutlet weak var applyCardTextField: UITextField!
    @IBOutlet weak var applyAddressTextField: UITextField!
    @IBOutlet weak var applyMobileTextField: UITextField!
    @IBOutlet weak var delegateNameTextField: UITextField!
    @IBOutlet weak var delegateAddressTextField: UITextField!
    @IBOutlet weak var delegateCardTextField: UITextField!
    @IBOutlet weak var delegateRelationTextField: UITextField!
    @IBOutlet weak var delegateMobileTextField: UITextField!
    @IBOutlet weak var nextBtn: IBDesignableButton!
    fileprivate lazy var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideKeyBoard()
    }
    
    /// 选择性别
    @IBAction func chooseSex(_ sender: UIButton) {
        hideKeyBoard()
        let view = YKAlertView.initView("选择性别", message: nil, style: YKAlertViewStyle.actionSheet)
        view.addButton("男", style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            self.applySexLabel.text = "男"
        }
        view.addButton("女", style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            self.applySexLabel.text = "女"
        }
        view.addButton(NSLocalizedString("alert.cancel", comment: ""), style: YKButtonStyle.cancel, color: YKButtonColor.normal, handler: nil)
        view.showView()
    }
    
    /// 选择生日
    @IBAction func chooseBirthday(_ sender: UIButton) {
        hideKeyBoard()
        showTimeAlert(applyBrithdayLabel)
    }
    
    /// 下一步
    @IBAction func nextBtnClick(_ sender: UIButton) {
        hideKeyBoard()
//        if !isTelNumber(applyMobileTextField.text! as NSString) {
//            YKProgressHUD.showError("请输入正确的手机号")
//            return
//        }
//        if !isIdentityCard(applyCardTextField.text! as NSString) {
//            YKProgressHUD.showError("身份证格式错误")
//            return
//        }
        YKProgressHUD.showHUD("", inView: self.view)
        YKHttpClient.shared.notaryApplyOne(applyNameTextField.text, apply_gender: applySexLabel.text, apply_birthday: applyBrithdayLabel.text, apply_IDcard_no: applyCardTextField.text, apply_workunit: applyAddressTextField.text, apply_cellphone: applyMobileTextField.text, agent_name: delegateNameTextField.text, agent_workunit: delegateAddressTextField.text, agent_IDcard_no: delegateCardTextField.text, apply_relations: delegateRelationTextField.text, agent_cellphone: delegateMobileTextField.text, completionHandler: { (notary_id, error) in
            YKProgressHUD.hide(false)
            if let notary_id = notary_id {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotaryApplyTwoID") as! YKNotaryApplyTwoController
                vc.title = "公证办理(2)"
                vc.notary_id = notary_id
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlert(error: error)
            }
        })
    }
    
    /// 选择时间弹窗
    func showTimeAlert(_ label: UILabel) {
        self.view.endEditing(true)
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.view.clipsToBounds = true
        // 初始化 datePicker
        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 10, width: kScreenWidth, height: 200)
        datePicker.center = CGPoint(x: alertController.view.center.x, y: datePicker.center.y)
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.date
        // 设置默认时间
        datePicker.date = Date()
        // 设置时间限制
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.minimumDate = timeFormatter.date(from: "1900-01-01")
        datePicker.maximumDate = NSDate() as Date
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)->Void in
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            let strNowTime = timeFormatter.string(from: datePicker.date) as String
            label.text = strNowTime
            self.checkTextField()
        })
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        
        alertController.view.addSubview(datePicker)
        datePicker.center = CGPoint(x: alertController.view.center.x, y: datePicker.center.y)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 初始化视图
    func setupView() {
        tableView.tableFooterView = UIView()
        applyNameTextField.layer.cornerRadius = 2
        applyNameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyNameTextField.leftViewMode = UITextFieldViewMode.always
        applyNameTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyNameTextField.rightViewMode = UITextFieldViewMode.always
        applyNameTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyCardTextField.layer.cornerRadius = 2
        applyCardTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyCardTextField.leftViewMode = UITextFieldViewMode.always
        applyCardTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyCardTextField.rightViewMode = UITextFieldViewMode.always
        applyCardTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyAddressTextField.layer.cornerRadius = 2
        applyAddressTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyAddressTextField.leftViewMode = UITextFieldViewMode.always
        applyAddressTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyAddressTextField.rightViewMode = UITextFieldViewMode.always
        applyAddressTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyMobileTextField.layer.cornerRadius = 2
        applyMobileTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyMobileTextField.leftViewMode = UITextFieldViewMode.always
        applyMobileTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyMobileTextField.rightViewMode = UITextFieldViewMode.always
        applyMobileTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        delegateNameTextField.layer.cornerRadius = 2
        delegateNameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateNameTextField.leftViewMode = UITextFieldViewMode.always
        delegateNameTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateNameTextField.rightViewMode = UITextFieldViewMode.always
        delegateNameTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        delegateAddressTextField.layer.cornerRadius = 2
        delegateAddressTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateAddressTextField.leftViewMode = UITextFieldViewMode.always
        delegateAddressTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateAddressTextField.rightViewMode = UITextFieldViewMode.always
        delegateAddressTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        delegateCardTextField.layer.cornerRadius = 2
        delegateCardTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateCardTextField.leftViewMode = UITextFieldViewMode.always
        delegateCardTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateCardTextField.rightViewMode = UITextFieldViewMode.always
        delegateCardTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        delegateRelationTextField.layer.cornerRadius = 2
        delegateRelationTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateRelationTextField.leftViewMode = UITextFieldViewMode.always
        delegateRelationTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateRelationTextField.rightViewMode = UITextFieldViewMode.always
        delegateRelationTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        delegateMobileTextField.layer.cornerRadius = 2
        delegateMobileTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateMobileTextField.leftViewMode = UITextFieldViewMode.always
        delegateMobileTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        delegateMobileTextField.rightViewMode = UITextFieldViewMode.always
        delegateMobileTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tableView.addGestureRecognizer(tap)
    }
    
    /// 检测textField
    func checkTextField() {
        if (applyNameTextField.text?.characters.count != 0 &&
            applySexLabel.text?.characters.count != 0 &&
            applyBrithdayLabel.text?.characters.count != 0 &&
            applyCardTextField.text?.characters.count != 0 &&
            applyAddressTextField.text?.characters.count != 0 &&
            applyMobileTextField.text?.characters.count != 0 &&
            delegateCardTextField.text?.characters.count == 0 &&
            delegateNameTextField.text?.characters.count == 0 &&
            delegateMobileTextField.text?.characters.count == 0 &&
            delegateAddressTextField.text?.characters.count == 0 &&
            delegateRelationTextField.text?.characters.count == 0) ||
            (applyNameTextField.text?.characters.count == 0 &&
                applySexLabel.text?.characters.count == 0 &&
                applyBrithdayLabel.text?.characters.count == 0 &&
                applyCardTextField.text?.characters.count == 0 &&
                applyAddressTextField.text?.characters.count == 0 &&
                applyMobileTextField.text?.characters.count == 0 &&
                delegateCardTextField.text?.characters.count != 0 &&
                delegateNameTextField.text?.characters.count != 0 &&
                delegateMobileTextField.text?.characters.count != 0 &&
                delegateAddressTextField.text?.characters.count != 0 &&
                delegateRelationTextField.text?.characters.count != 0) {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
}
