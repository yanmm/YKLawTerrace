//
//  YKDetailsController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/23.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

enum YKDetailsType {
    case lssws  // 律师事务所
    case ls     // 律师
    case gzc    // 公证处
    case gzy    // 公证员
    case rmyyh  // 人民调解委员会
    case sfjdjg // 司法鉴定机构
    case sfxzjg // 司法行政机构
    case flfws  // 基层法律服务所
}

class YKDetailsController: YKBaseViewController,YKSelectedDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var noDataView: YKNoDataView!
    fileprivate var page = 1
    fileprivate var LSSWSArray: [WEYLawfirm] = []
    fileprivate var LSArray: [WEYLawers] = []
    var type: YKDetailsType!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        tableView.tableFooterView = UIView()
        
        if self.type == .lssws {
            self.searchLSSWS(true, isFooterRefreshing: false)
        } else if self.type == .ls {
            self.searchLS(true, isFooterRefreshing: false)
        } else if self.type == .gzc {
            self.searchGZC(true, isFooterRefreshing: false)
        } else if self.type == .gzy {
            self.searchGZY(true, isFooterRefreshing: false)
        } else if self.type == .rmyyh {
            self.searchRMYYH(true, isFooterRefreshing: false)
        } else if self.type == .sfjdjg {
            self.searchSFJDJG(true, isFooterRefreshing: false)
        } else if self.type == .sfxzjg {
            self.searchSFXZJG(true, isFooterRefreshing: false)
        } else {
            self.searchFLFWS(true, isFooterRefreshing: false)
        }
        noDataView = YKNoDataView.show("暂无数据", btnTitle: nil)
        noDataView.frame = self.view.frame
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingBlock: {
            if self.type == .lssws {
                self.searchLSSWS(true, isFooterRefreshing: false)
            } else if self.type == .ls {
                self.searchLS(true, isFooterRefreshing: false)
            } else if self.type == .gzc {
                self.searchGZC(true, isFooterRefreshing: false)
            } else if self.type == .gzy {
                self.searchGZY(true, isFooterRefreshing: false)
            } else if self.type == .rmyyh {
                self.searchRMYYH(true, isFooterRefreshing: false)
            } else if self.type == .sfjdjg {
                self.searchSFJDJG(true, isFooterRefreshing: false)
            } else if self.type == .sfxzjg {
                self.searchSFXZJG(true, isFooterRefreshing: false)
            } else {
                self.searchFLFWS(true, isFooterRefreshing: false)
            }
        })
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            if self.type == .lssws {
                self.searchLSSWS(false, isFooterRefreshing: true)
            } else if self.type == .ls {
                self.searchLS(false, isFooterRefreshing: true)
            } else if self.type == .gzc {
                self.searchGZC(false, isFooterRefreshing: true)
            } else if self.type == .gzy {
                self.searchGZY(false, isFooterRefreshing: true)
            } else if self.type == .rmyyh {
                self.searchRMYYH(false, isFooterRefreshing: true)
            } else if self.type == .sfjdjg {
                self.searchSFJDJG(false, isFooterRefreshing: true)
            } else if self.type == .sfxzjg {
                self.searchSFXZJG(false, isFooterRefreshing: true)
            } else {
                self.searchFLFWS(false, isFooterRefreshing: true)
            }
        })
        header.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }
    
    /// 获取基层法律服务所
    func searchFLFWS(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.legal(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取司法行政机构
    func searchSFXZJG(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.judicial(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取司法鉴定机构
    func searchSFJDJG(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.identify(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取人民调解委员会
    func searchRMYYH(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.committee(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取公证员
    func searchGZY(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.notaryer(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSArray.count > 0 {
                    self.LSArray.removeAll()
                }
                
                self.LSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取公证处
    func searchGZC(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.notary(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取律师
    func searchLS(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.lawer(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSArray.count > 0 {
                    self.LSArray.removeAll()
                }
                
                self.LSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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
    
    /// 获取律师事务所
    func searchLSSWS(_ isHeaderRefreshing: Bool, isFooterRefreshing: Bool) {
        if isHeaderRefreshing && LSSWSArray.count > 0 {
            page = 1
            tableView.mj_footer.resetNoMoreData()
        }
        
        if isFooterRefreshing {
            page += 1
        }
        
        YKHttpClient.shared.lawfirm(cityLabel.text!, page: page) { (data, error) in
            if let data = data {
                if isHeaderRefreshing && self.LSSWSArray.count > 0 {
                    self.LSSWSArray.removeAll()
                }
                
                self.LSSWSArray.append(contentsOf: data)
                self.tableView.reloadData()
                
                if self.LSSWSArray.count == 0 {
                    self.page = 1
                    self.tableView.addSubview(self.noDataView)
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

    @IBAction func chooseCity(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKMe", bundle: nil).instantiateViewController(withIdentifier: "SelectedID") as! YKSelectedController
        vc.title = "选择区域"
        vc.titleArray = ["右江区","田阳县","田东县","平果县","德保县","靖西县","那坡县","凌云县","乐业县","田林县","西林县","隆林各族自治县"]
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type == .ls || self.type == .gzy {
            return LSArray.count
        } else {
            return LSSWSArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.type == .ls || self.type == .gzy {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsChatCell", for: indexPath) as! YKDetailsChatCell
            cell.bindData(LSArray[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! YKDetailsCell
            cell.bindLSSWSData(LSSWSArray[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.type == .ls || self.type == .gzy {
            if let chat = YKChatController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "\(LSArray[indexPath.row].user_id)") {
                chat.title = LSArray[indexPath.row].username
                self.navigationController?.pushViewController(chat, animated: true)
            }
        } else {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapID") as! YKMapController
//            let toAddress = BMKPlanNode()
//            toAddress.pt.longitude = LSSWSArray[indexPath.row].longitude
//            toAddress.pt.latitude = LSSWSArray[indexPath.row].latitude
//            vc.toAddress = toAddress
//            vc.title = "地图"
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //让分割线和文字对齐
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func chooseSuccess(_ selected: [YKSelectedModel], index: Int) {
        cityLabel.text = selected[0].title
        if self.type == .lssws {
            self.searchLSSWS(true, isFooterRefreshing: false)
        } else if self.type == .ls {
            self.searchLS(true, isFooterRefreshing: false)
        } else if self.type == .gzc {
            self.searchGZC(true, isFooterRefreshing: false)
        } else if self.type == .gzy {
            self.searchGZY(true, isFooterRefreshing: false)
        } else if self.type == .rmyyh {
            self.searchRMYYH(true, isFooterRefreshing: false)
        } else if self.type == .sfjdjg {
            self.searchSFJDJG(true, isFooterRefreshing: false)
        } else if self.type == .sfxzjg {
            self.searchSFXZJG(true, isFooterRefreshing: false)
        } else {
            self.searchFLFWS(true, isFooterRefreshing: false)
        }
    }
}
