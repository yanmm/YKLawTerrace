//
//  YKEditNicknameController.swift
//  YKProject
//
//  Created by Yuki on 2016/16/9.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

protocol YKEditNicknameDelegate {
    func changeNameSuccess(_ name: String)
}

class YKEditNicknameController: YKBaseViewController {
    @IBOutlet weak var limitNumLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    fileprivate var saveButton:UIButton!
    fileprivate var maxText = ""
    var nickName: String!
    var delegate: YKEditNicknameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nickNameTextField.text = nickName
        nickNameTextField.placeholder = "请输入昵称"
        nickNameTextField.addTarget(self, action: #selector(EidtingChanged), for: UIControlEvents.editingChanged)
        
        let saveButton = UIButton(type: UIButtonType.custom)
        saveButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        saveButton.setTitle("保存", for: UIControlState())
        saveButton.setTitleColor(UIColor.black, for: UIControlState())
        saveButton.addTarget(self, action: #selector(saveNickname), for: UIControlEvents.touchUpInside)
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -30
        
        navigationItem.rightBarButtonItems = [spaceItem,UIBarButtonItem(customView: saveButton)]
        self.saveButton = saveButton
        
        if nickName == nickNameTextField.text {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(hex6: 0xD5D5D5), for: UIControlState())
        }
        maxText = nickName
        
        limitNumLabel.text = "\(16 - (nickNameTextField.text?.characters.count ?? 0))"
    }

    func saveNickname() {
        if let nickname = self.nickNameTextField.text {
            self.delegate?.changeNameSuccess(nickname)
            self.navigationController?.popViewController(animated: true)
            YKHttpClient.shared.updateUser(nickname, avatar: nil, completionHandler: { (error) in
                if error == nil {
                    YKUser.shared.nickname = nickname
                    YKProgressHUD.showSuccess("修改成功")
                    let time: TimeInterval = kDelayTime_Of_HUD
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.navigationController?.popViewController(animated: true)
                        self.delegate?.changeNameSuccess(nickname)
                    }
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
    
    func EidtingChanged(_ sender:UITextField) {
        if sender.text == "" {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(hex6: 0xD5D5D5), for: UIControlState())
        } else {
            saveButton.isEnabled = true
            saveButton.setTitleColor(UIColor.white, for: UIControlState())
        }
        
        if sender.text == nickName {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(hex6: 0xD5D5D5), for: UIControlState())
        }
        if (nickNameTextField.text?.characters.count ?? 0) > 16 {
            self.nickNameTextField.text = maxText
        } else {
            maxText = self.nickNameTextField.text!
        }
        
        limitNumLabel.text = "\(16 - (nickNameTextField.text?.characters.count ?? 0))"
    }
}
