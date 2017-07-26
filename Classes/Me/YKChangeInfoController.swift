//
//  YKChangeInfoController.swift
//  YKProject
//
//  Created by Yuki on 2016/12/8.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

struct YKChangeInfoModel {
    var title = ""
    var desc = ""
    var image = ""
}

class YKChangeInfoController: YKPhotoTableViewController,YKEditNicknameDelegate {
    fileprivate var cellArray: [[YKChangeInfoModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        setupView()
    }
    
    /// 初始化试图
    func setupView() {
        cellArray.removeAll()
        cellArray.append([])
        cellArray[0].append(YKChangeInfoModel(title: "头像", desc: "", image: YKUser.shared.avatar))
        cellArray[0].append(YKChangeInfoModel(title: "昵称", desc: YKUser.shared.nickname, image: ""))
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "changeInfoCellOne", for: indexPath) as! YKChangeInfoCellOne
            cell.bindData(cellArray[indexPath.section][indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "changeInfoCellTwo", for: indexPath) as! YKChangeInfoCellTwo
            cell.bindData(cellArray[indexPath.section][indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.showSheetView()
            case 1:
                let vc =  self.storyboard?.instantiateViewController(withIdentifier: "EditNicknameID") as! YKEditNicknameController
                vc.nickName = YKUser.shared.nickname
                vc.delegate = self
                vc.title = "修改昵称"
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
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
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! YKChangeInfoCellOne
            
            YKHttpClient.shared.updateUser(YKUser.shared.nickname, avatar: image, completionHandler: { (error) in
                if error == nil {
                    YKProgressHUD.popupSuccess("修改成功")
                    cell.iconImage.image = image
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kChangeInfoNotification), object: nil)
                } else {
                    self.showAlert(error: error)
                }
            })
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// YKEditNicknameDelegate
    func changeNameSuccess(_ name: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: kChangeInfoNotification), object: nil)
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! YKChangeInfoCellTwo
        cell.descLabel.text = name
    }
}
