//
//  YKLawApplyFourController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/14.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyFourController: YKBaseTableViewController,YKSelectedDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var nextBtn: IBDesignableButton!
    @IBOutlet weak var getTextField: UITextField!
    @IBOutlet weak var saveTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var baseTextField: UITextField!
    fileprivate var cellArray: [[String]] = []
    var assist_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append("申请事项法律状态")
        cellArray.append([])
        cellArray[1].append("申请法律援助方式")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.delegate = self
        tableView.addGestureRecognizer(tap)
        
        getTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        saveTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        numTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        monthTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
        baseTextField.addTarget(self, action: #selector(checkTextField), for: UIControlEvents.editingChanged)
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
        if let get = getTextField.text, let save = saveTextField.text, let num = numTextField.text, let month = monthTextField.text, let base = baseTextField.text {
            YKProgressHUD.showHUD("", inView: self.view)
            YKHttpClient.shared.lawAssistFour(self.assist_id, legalcase_state: cellArray[0][1], legalcase_mode: cellArray[1][1], profession_income: get, benefits: save, family_nums: num, average_income: month, basic_expense: base, completionHandler: { (id, error) in
                YKProgressHUD.hide(false)
                if let id = id {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LawApplyFiveID") as! YKLawApplyFiveController
                    vc.title = "法律援助(5)"
                    vc.assist_id = id
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showAlert(error: error)
                }
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lawApplyTwoCell", for: indexPath) as! YKLawApplyTwoCell
        if indexPath.row == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.default
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        cell.bindData(cellArray[indexPath.section][indexPath.row], indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            hideKeyBoard()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
            switch indexPath.section {
            case 0:
                vc.title = "申请事项法律状态"
                vc.titleArray = ["尚未进入法律程序","侦查","起诉","诉讼（一审）","诉讼（二审）","诉讼（重审）","诉讼（审判监督程序）","申诉","仲裁","调解","行政处理","行政复议"]
            case 1:
                vc.title = "申请法律援助方式"
                vc.titleArray = ["刑事辩护","刑事被害人代理","刑事附带民事诉讼","自诉代理","民事诉讼代理","行政诉讼代理","非诉讼代理","劳动仲裁代理","其他"]
            default:
                break
            }
            vc.delegate = self
            vc.index = indexPath.section
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == cellArray[indexPath.section].count - 1 ? 0 : 15
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    /// 检测textField
    func checkTextField() {
        if getTextField.text?.characters.count != 0 &&
            saveTextField.text?.characters.count != 0 &&
            numTextField.text?.characters.count != 0 &&
            monthTextField.text?.characters.count != 0 &&
            baseTextField.text?.characters.count != 0 &&
            cellArray[0].count > 1 &&
            cellArray[1].count > 1 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x54ACEB)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
        }
    }
    
    /// YKSelectedDelegate
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        cellArray[index].removeAll()
        if index == 0 {
            cellArray[0].append("申请事项法律状态")
        }
        if index == 1 {
            cellArray[1].append("申请法律援助方式")
        }
        for selec in selected {
            cellArray[index].append(selec.title)
        }
        if cellArray[0].count > 1 && cellArray[1].count > 1 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
        }
        checkTextField()
        tableView.reloadData()
    }
    
    /// UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(NSStringFromClass((touch.view?.classForCoder)!))
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }
}
