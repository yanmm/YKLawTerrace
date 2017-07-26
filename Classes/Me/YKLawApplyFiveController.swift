//
//  YKLawApplyFiveController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/24.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyFiveController: YKBaseTableViewController,YKSelectedDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var houseTextField: UITextField!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet weak var nextBtn: IBDesignableButton!
    var assist_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        moneyTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        houseTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.delegate = self
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

    @IBAction func nextBtnClick(_ sender: UIButton) {
        hideKeyBoard()
        if contextTextView.text.characters.count == 0 {
            YKProgressHUD.popupError("请输入申请法律援助的案情及理由概述")
            return
        }
        if let economic_amount = moneyTextField.text, let build_size = houseTextField.text, let build_use_state = useLabel.text, let case_intro = contextTextView.text {
            YKHttpClient.shared.lawAssistFive(self.assist_id, economic_amount: economic_amount, build_size: build_size, build_use_state: build_use_state, case_intro: case_intro, completionHandler: { (error) in
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
    
    @IBAction func chooseUse(_ sender: UIButton) {
        hideKeyBoard()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
        vc.title = "使用状况"
        vc.titleArray = ["自用","出租"]
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 检测textField
    func checkTextField() {
        if moneyTextField.text?.characters.count != 0 &&
            houseTextField.text?.characters.count != 0 &&
            useLabel.text?.characters.count != 0 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }
    
    /// YKSelectedDelegate
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        useLabel.text = selected[0].title
        checkTextField()
    }
    
    /// UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(NSStringFromClass((touch.view?.classForCoder)!))
        if NSStringFromClass((touch.view?.classForCoder)!) == "UIView" {
            return false
        }
        return true
    }
}
