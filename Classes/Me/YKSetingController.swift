//
//  YKSetingController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKSetingController: YKBaseTableViewController {
    fileprivate var cellArray: [[YKMeCellModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    /// 初始化试图
    func setupView() {
        self.title = "设置"
        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        cellArray.append([])
        cellArray[0].append(YKMeCellModel(image: "", title: "清理缓存"))
        cellArray.append([])
        cellArray[1].append(YKMeCellModel(image: "", title: "关于我们"))
        cellArray[1].append(YKMeCellModel(image: "", title: "联系我们"))
        tableView.reloadData()
    }

    @IBAction func logout(_ sender: UIButton) {
        let vc = UIAlertController(title: "确定退出登录？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action1 = UIAlertAction(title: NSLocalizedString("alert.cancel", comment: ""), style: UIAlertActionStyle.destructive, handler: nil)
        let action2 = UIAlertAction(title: NSLocalizedString("alert.ok", comment: ""), style: UIAlertActionStyle.default, handler: { (action2) in
            YKUser.shared.loginout()
        })
        vc.addAction(action1)
        vc.addAction(action2)
        
        self.present(vc,animated: true,completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setingCell", for: indexPath) as! YKSetingCell
        cell.bindData(cellArray[indexPath.section][indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let vc = UIAlertController(title: "是否清理缓存？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let action1 = UIAlertAction(title: NSLocalizedString("alert.ok", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
                SDImageCache.shared().cleanDisk()
                SDImageCache.shared().clearMemory()
                Thread.sleep(forTimeInterval: 0.5)
                YKProgressHUD.popupSuccess("清理成功")
            })
            let action2 = UIAlertAction(title: NSLocalizedString("alert.cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil)
            vc.addAction(action2)
            vc.addAction(action1)
            self.present(vc, animated: true, completion: nil)
        case 1:
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutID") as! YKAboutController
                vc.title = "关于我们"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CallUsID") as! YKCallUsController
                vc.title = "联系我们"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
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
}
