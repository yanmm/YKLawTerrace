//
//  YKLawApplyOneController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/13.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyOneController: YKBaseTableViewController,YKSelectedDelegate {
    @IBOutlet weak var applyNameTextField: UITextField!
    @IBOutlet weak var applySexLabel: UILabel!
    @IBOutlet weak var applyBrithdayLabel: UILabel!
    @IBOutlet weak var applyCardTextField: UITextField!
    @IBOutlet weak var applyAddressTextField: UITextField!
    @IBOutlet weak var applyMobileTextField: UITextField!
    @IBOutlet weak var nationTextField: UITextField!
    @IBOutlet weak var legalTextField: UITextField!
    @IBOutlet weak var workPlaceTextField: UITextField!
    @IBOutlet weak var homeTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var eduLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
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
    
    /// 选择身体状况
    @IBAction func chooseBody(_ sender: UIButton) {
        hideKeyBoard()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
        vc.title = "选择身体状况"
        vc.titleArray = ["健康","残疾","严重疾病"]
        vc.delegate = self
        vc.index = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 选择文化程度
    @IBAction func chooseEdu(_ sender: UIButton) {
        hideKeyBoard()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
        vc.title = "选择文化程度"
        vc.titleArray = ["文盲","小学","中学","大专以上"]
        vc.delegate = self
        vc.index = 0
        self.navigationController?.pushViewController(vc, animated: true)
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
        if !isTelNumber(applyMobileTextField.text! as NSString) {
            YKProgressHUD.popupError("请输入正确的手机号")
            return
        }
        if !isIdentityCard(applyCardTextField.text! as NSString) {
            YKProgressHUD.popupError("身份证格式错误")
            return
        }
        if let applicant = applyNameTextField.text, let gender = applySexLabel.text, let birthday = applyBrithdayLabel.text, let nation = nationTextField.text, let IDcard_no = applyCardTextField.text, let domicile_place = applyAddressTextField.text, let cellphone = applyMobileTextField.text, let workunit = workPlaceTextField.text, let home_place = homeTextField.text, let postcode = postcodeTextField.text, let edu_level = eduLabel.text, let physical_state = bodyLabel.text {
            YKHttpClient.shared.lawAssistOne(applicant, gender: gender, birthday: birthday, nation: nation, legal_person: self.legalTextField.text, IDcard_no: IDcard_no, domicile_place: domicile_place, cellphone: cellphone, workunit: workunit, home_place: home_place, postcode: postcode, edu_level: edu_level, physical_state: physical_state, completionHandler: { (assist_id, error) in
                if let assist_id = assist_id {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LawApplyTwoID") as! YKLawApplyTwoController
                    vc.title = "法律援助(2)"
                    vc.assist_id = assist_id
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showAlert(error: error)
                }
            })
        }
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
        applyNameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyNameTextField.leftViewMode = UITextFieldViewMode.always
        applyNameTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyNameTextField.rightViewMode = UITextFieldViewMode.always
        applyNameTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyCardTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyCardTextField.leftViewMode = UITextFieldViewMode.always
        applyCardTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyCardTextField.rightViewMode = UITextFieldViewMode.always
        applyCardTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyAddressTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyAddressTextField.leftViewMode = UITextFieldViewMode.always
        applyAddressTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyAddressTextField.rightViewMode = UITextFieldViewMode.always
        applyAddressTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        applyMobileTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyMobileTextField.leftViewMode = UITextFieldViewMode.always
        applyMobileTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        applyMobileTextField.rightViewMode = UITextFieldViewMode.always
        applyMobileTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        nationTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        nationTextField.leftViewMode = UITextFieldViewMode.always
        nationTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        nationTextField.rightViewMode = UITextFieldViewMode.always
        nationTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        legalTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        legalTextField.leftViewMode = UITextFieldViewMode.always
        legalTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        legalTextField.rightViewMode = UITextFieldViewMode.always
        legalTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        workPlaceTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        workPlaceTextField.leftViewMode = UITextFieldViewMode.always
        workPlaceTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        workPlaceTextField.rightViewMode = UITextFieldViewMode.always
        workPlaceTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        homeTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        homeTextField.leftViewMode = UITextFieldViewMode.always
        homeTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        homeTextField.rightViewMode = UITextFieldViewMode.always
        homeTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        postcodeTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        postcodeTextField.leftViewMode = UITextFieldViewMode.always
        postcodeTextField.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 44))
        postcodeTextField.rightViewMode = UITextFieldViewMode.always
        postcodeTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tableView.addGestureRecognizer(tap)
    }

    /// 检测textField
    func checkTextField() {
        if applyNameTextField.text?.characters.count != 0 &&
            applyCardTextField.text?.characters.count != 0 &&
            applyMobileTextField.text?.characters.count != 0 &&
            applyAddressTextField.text?.characters.count != 0 &&
            nationTextField.text?.characters.count != 0 &&
            workPlaceTextField.text?.characters.count != 0 &&
            homeTextField.text?.characters.count != 0 &&
            postcodeTextField.text?.characters.count != 0 {
            if let brithday = applyBrithdayLabel.text, let edu = eduLabel.text, let body = bodyLabel.text {
                if brithday != "" && edu != "" && body != "" {
                    nextBtn.isEnabled = true
                    nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
                }
            }
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }
    
    /// 隐藏键盘
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    /// YKSelectedDelegate
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        if index == 0 {
            self.eduLabel.text = selected[0].title
        }
        if index == 1 {
            self.bodyLabel.text = selected[0].title
        }
        self.checkTextField()
    }
}
