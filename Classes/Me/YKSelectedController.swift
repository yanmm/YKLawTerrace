//
//  YKSelectedController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/14.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

struct YKSelectedModel {
    var title = ""
    var isChoose = false
}

protocol YKSelectedDelegate {
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int)
}

class YKSelectedController: YKBaseTableViewController {
    fileprivate var cellArray: [YKSelectedModel] = []
    fileprivate var selectedArray: [YKSelectedModel] = []
    var isSimple = true // 默认单选
    var titleArray: [String] = []
    var delegate: YKSelectedDelegate?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        for (i, title) in titleArray.enumerated() {
            cellArray.append(YKSelectedModel(title: title, isChoose: false))
            if i == titleArray.count - 1 {
                tableView.reloadData()
            }
        }
        if !isSimple {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(okClick))
        }
    }
    
    /// 多选完成
    func okClick() {
        if selectedArray.count == 0 {
            YKProgressHUD.popupError("还未选中任何选项")
            return
        }
        self.delegate?.chooseSuccess(selectedArray, index: index)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedCell", for: indexPath) as! YKSelectedCell
        cell.bindData(cellArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isSimple {
            self.delegate?.chooseSuccess([cellArray[indexPath.row]], index: self.index)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.cellArray[indexPath.row].isChoose = !self.cellArray[indexPath.row].isChoose
            if self.cellArray[indexPath.row].isChoose {
                self.selectedArray.append(cellArray[indexPath.row])
            } else {
                for (i, select) in self.selectedArray.enumerated() {
                    if select.title == cellArray[indexPath.row].title {
                        self.selectedArray.remove(at: i)
                        break
                    }
                }
            }
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
    
    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == cellArray.count - 1 ? 0 : 15
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
}
