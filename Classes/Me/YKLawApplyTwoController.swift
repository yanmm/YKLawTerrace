//
//  YKLawApplyTwoController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/13.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKLawApplyTwoController: YKBaseTableViewController,YKSelectedDelegate {
    @IBOutlet weak var nextBtn: IBDesignableButton!
    fileprivate var cellArray: [[String]] = []
    var assist_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append("人群类别（可多选）")
        cellArray.append([])
        cellArray[1].append("申请法律援助事项类别")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = UIColor(hex6: 0xE3E3E3)
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        var oneArray = cellArray[0]
        oneArray.removeFirst()
        var twoArray = cellArray[1]
        twoArray.removeFirst()
        YKProgressHUD.showHUD("", inView: self.view)
        YKHttpClient.shared.lawAssistTwo(self.assist_id, crowd_cate: oneArray, assist_cate: twoArray) { (id, error) in
            YKProgressHUD.hide(false)
            if let id = id {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LawApplyThreeID") as! YKLawApplyThreeController
                vc.title = "法律援助(3)"
                vc.assist_id = id
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlert(error: error)
            }
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
            switch indexPath.section {
            case 0:
                vc.title = "申请人群类别"
                vc.isSimple = false
                vc.titleArray = ["残疾人","老年人（60岁以上）","未成年人","妇女","优抚对象","农材五保户","低保户","农名工","失业人员","少数民族","军人军属","聋盲哑","可能被判决死刑的","其他"]
                
            case 1:
                vc.title = "申请法律援助类别"
                vc.titleArray = ["刑事案件","请求国家赔","请求给予最低保障待遇或社会保险待遇","请求发给抚恤金、救济金","请求给付赡养费、抚养费、扶养费","请求支付劳动报酬","主张因见义勇为行为产生的民事权益","其他（省人民政府补充规定的法律援助事项）"]
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
            cellArray[0].append("人群类别（可多选）")
        }
        if index == 1 {
            cellArray[1].append("申请法律援助事项类别")
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
