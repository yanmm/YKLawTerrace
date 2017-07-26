//
//  YKLawApplyThreeController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/14.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyThreeController: YKBaseTableViewController,YKSelectedDelegate {
    @IBOutlet weak var nextBtn: IBDesignableButton!
    fileprivate var cellArray: [[String]] = []
    var assist_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append("申请法律类型")
        cellArray.append([])
        cellArray[1].append("申请人在事项中的法律地位")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        if let legalcase_cate: String = cellArray[0][1], let legalcase_role: String = cellArray[1][1] {
            YKProgressHUD.showHUD("", inView: self.view)
            YKHttpClient.shared.lawAssistThree(self.assist_id, legalcase_cate: legalcase_cate, legalcase_role: legalcase_role, completionHandler: { (id, error) in
                YKProgressHUD.hide(false)
                if let id = id {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LawApplyFourID") as! YKLawApplyFourController
                    vc.title = "法律援助(4)"
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
            if indexPath.section == 1 && cellArray[0].count == 1 {
                YKProgressHUD.showError("请先选择法律类型")
                return
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
            switch indexPath.section {
            case 0:
                vc.title = "申请法律类型"
                vc.titleArray = ["民事诉讼","行政诉讼","劳动仲裁","非诉讼","刑事诉讼"]
            case 1:
                vc.title = "申请人在事项中的法律地位"
                if cellArray[0][1] == "民事诉讼" {
                    vc.titleArray = ["原告（上诉人）","被告（被上诉人）","第三人"]
                }
                if cellArray[0][1] == "行政诉讼" {
                    vc.titleArray = ["原告（上诉人）","被告（被上诉人）","第三人"]
                }
                if cellArray[0][1] == "劳动仲裁" {
                    vc.titleArray = ["申请人","被申请人"]
                }
                if cellArray[0][1] == "非诉讼" {
                    vc.titleArray = ["申请人","被申请人"]
                }
                if cellArray[0][1] == "刑事诉讼" {
                    vc.titleArray = ["犯罪嫌疑人","被害人","被害人的代理人或其近亲属","自诉人","自诉人的法定代理人","被告人"]
                }
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
    
    /// YKSelectedDelegate
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        cellArray[index].removeAll()
        if index == 0 {
            cellArray[0].append("申请法律类型")
            cellArray[1].removeAll()
            cellArray[1].append("申请人在事项中的法律地位")
        }
        if index == 1 {
            cellArray[1].append("申请人在事项中的法律地位")
        }
        for selec in selected {
            cellArray[index].append(selec.title)
        }
        if cellArray[0].count > 1 && cellArray[1].count > 1 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(hex6: 0x58ADE8)
        }
        tableView.reloadData()
    }
}
