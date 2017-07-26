//
//  YKDynamicDetailController.swift
//  YKProject
//
//  Created by Yuki on 2017/1/7.
//  Copyright © 2017年 Yuki. All rights reserved.
//

import UIKit

class YKDynamicDetailController: YKBaseTableViewController {
    fileprivate var newsDetail: WEYNewsList?
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        searchDetail()
    }
    
    /// 获取新闻详情
    func searchDetail() {
        YKHttpClient.shared.detail(id) { (data, error) in
            if let data = data {
                self.newsDetail = data
                self.tableView.reloadData()
            } else {
                self.showAlert(error: error)
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = newsDetail {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicDetailCell", for: indexPath) as! YKDynamicDetailCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if let data = newsDetail {
            cell.bindData(data)
        }
        return cell
    }
}
