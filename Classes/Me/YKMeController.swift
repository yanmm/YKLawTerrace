//
//  YKMeController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKMeController: YKBaseTableViewController {
    fileprivate var cellArray: [[YKMeCellModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(changeInfoNotification), name: NSNotification.Name(rawValue: kChangeInfoNotification), object: nil)
    }
    
    /// 初始化试图
    func setupView() {
        self.title = "我的"
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append(YKMeCellModel(image:  YKUser.shared.avatar, title: YKUser.shared.nickname))
        cellArray.append([])
        cellArray[1].append(YKMeCellModel(image: "Me_cell0", title: "修改密码"))
        cellArray[1].append(YKMeCellModel(image: "Me_cell1", title: "联系我们"))
        cellArray[1].append(YKMeCellModel(image: "Me_cell2", title: "法律援助"))
        cellArray[1].append(YKMeCellModel(image: "Me_cell3", title: "公证办理"))
        cellArray.append([])
        cellArray[2].append(YKMeCellModel(image: "Me_set", title: "设置"))
        tableView.reloadData()
    }
    
    /// 修改个人信息通知
    func changeInfoNotification() {
        YKRunTime().getUserInfo(withUserId: String(YKUser.shared.userid)) { (info) in
            self.cellArray[0][0] = YKMeCellModel(image:  YKUser.shared.avatar, title: YKUser.shared.nickname)
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.none)
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "meCellOne", for: indexPath) as! YKMeCellOne
            cell.bindData(cellArray[indexPath.section][indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "meCellTwo", for: indexPath) as! YKMeCellTwo
            cell.bindData(cellArray[indexPath.section][indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeInfoID") as! YKChangeInfoController
            vc.title = "个人信息"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            if indexPath.row == 0 {
                let vc = UIStoryboard(name: "YKLogin", bundle: nil).instantiateViewController(withIdentifier: "PasswordID") as! YKPasswordController
                vc.title = "修改密码"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CallUsID") as! YKCallUsController
                vc.title = "联系我们"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LawApplyOneID") as! YKLawApplyOneController
                vc.title = "法律援助(1)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 3 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotaryApplyOneID") as! YKNotaryApplyOneController
                vc.title = "公证办理(1)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetingID") as! YKSetingController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == cellArray[indexPath.section].count - 1 ? 0 : 14
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
}
