//
//  YKDynamicController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/12.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKDynamicController: YKBaseTableViewController {
    fileprivate var newsArray: [WEYNewsList] = []
    fileprivate var noDataView = YKNoDataView.show("暂无动态", btnTitle: nil)
    fileprivate var page = 1
    var type = 2 // 0工作动态  1办事指南 2法律法规 3法律宣传
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.title == nil {
            self.title = "动态"
        }
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        
        switch type {
        case 0:
            searchDynamicList(true, isFooterRefreshing: false)
        case 1:
            searchGuideList(true, isFooterRefreshing: false)
        case 2:
            searchStatuteList(true, isFooterRefreshing: false)
        case 3:
            searchLegalList(true, isFooterRefreshing: false)
        default:
            break
        }
        noDataView.frame = self.view.frame
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingBlock: {
            switch self.type {
            case 0:
                self.searchDynamicList(true, isFooterRefreshing: false)
            case 1:
                self.searchGuideList(true, isFooterRefreshing: false)
            case 2:
                self.searchStatuteList(true, isFooterRefreshing: false)
            case 3:
                self.searchLegalList(true, isFooterRefreshing: false)
            default:
                break
            }
        })
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            switch self.type {
            case 0:
                self.searchDynamicList(false, isFooterRefreshing: true)
            case 1:
                self.searchGuideList(false, isFooterRefreshing: true)
            case 2:
                self.searchStatuteList(false, isFooterRefreshing: true)
            case 3:
                self.searchLegalList(false, isFooterRefreshing: true)
            default:
                break
            }
        })
        header.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// 获取工作动态列表
    func searchDynamicList(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && newsArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.dynamic(page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.newsArray.count > 0 {
                    self.newsArray.removeAll()
                }
                
                self.newsArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.newsArray.count == 0 {
                    self.view.addSubview(self.noDataView)
                } else {
                    self.noDataView.removeFromSuperview()
                }
                if data.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                self.showAlert(error: error)
            }
            if self.tableView.mj_footer.isRefreshing() {
                self.tableView.mj_footer.endRefreshing()
            }
            if self.tableView.mj_header.isRefreshing() {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    /// 获取办事指南列表
    func searchGuideList(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && newsArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.guide(page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.newsArray.count > 0 {
                    self.newsArray.removeAll()
                }
                
                self.newsArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.newsArray.count == 0 {
                    self.view.addSubview(self.noDataView)
                } else {
                    self.noDataView.removeFromSuperview()
                }
                if data.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                self.showAlert(error: error)
            }
            if self.tableView.mj_footer.isRefreshing() {
                self.tableView.mj_footer.endRefreshing()
            }
            if self.tableView.mj_header.isRefreshing() {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    /// 获取法律法规列表
    func searchStatuteList(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && newsArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.statute(page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.newsArray.count > 0 {
                    self.newsArray.removeAll()
                }
                
                self.newsArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.newsArray.count == 0 {
                    self.view.addSubview(self.noDataView)
                } else {
                    self.noDataView.removeFromSuperview()
                }
                if data.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                self.showAlert(error: error)
            }
            if self.tableView.mj_footer.isRefreshing() {
                self.tableView.mj_footer.endRefreshing()
            }
            if self.tableView.mj_header.isRefreshing() {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    /// 获取法律宣传列表
    func searchLegalList(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && newsArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.legal(page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.newsArray.count > 0 {
                    self.newsArray.removeAll()
                }
                
                self.newsArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.newsArray.count == 0 {
                    self.view.addSubview(self.noDataView)
                } else {
                    self.noDataView.removeFromSuperview()
                }
                if data.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                self.showAlert(error: error)
            }
            if self.tableView.mj_footer.isRefreshing() {
                self.tableView.mj_footer.endRefreshing()
            }
            if self.tableView.mj_header.isRefreshing() {
                self.tableView.mj_header.endRefreshing()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicCell", for: indexPath) as! YKDynamicCell
        cell.bindData(newsArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = YKHTMLController()
        vc.urlStr = kAPI_HOST_HTTP + "/touch/app/newsDetail?id=\(newsArray[indexPath.row].id)"
        vc.title = newsArray[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //让分割线和文字对齐
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left: CGFloat = indexPath.row == 10 - 1 ? 0 : 15
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: left, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
}
