//
//  YKRegisterController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKRegisterController: YKBaseTableViewController {
    fileprivate var cellArray: [[YKRegisterModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCell()
    }
    
    /// 初始化cell
    func setupCell() {
        self.title = "选择身份"
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append(YKRegisterModel(title: "平台用户", desc: ""))
        
        cellArray.append([])
        cellArray[1].append(YKRegisterModel(title: "律    师", desc: "（需审核）"))
        cellArray[1].append(YKRegisterModel(title: "法律服务工作者", desc: "（需审核）"))
        cellArray[1].append(YKRegisterModel(title: "公证员", desc: "（需审核）"))
        cellArray[1].append(YKRegisterModel(title: "司法局工作员", desc: "（需审核）"))
        cellArray[1].append(YKRegisterModel(title: "鉴定机构人员", desc: "（需审核）"))
        cellArray[1].append(YKRegisterModel(title: "人民调解员", desc: "（需审核）"))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerCell", for: indexPath) as! YKRegisterCell
        cell.bindData(cellArray[indexPath.section][indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterInfoID") as! YKRegisterInfoController
        vc.title = "注册"
        vc.type = indexPath.row + indexPath.section
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == cellArray.count - 1 ? 0 : 15
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
}
