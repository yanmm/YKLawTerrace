//
//  YKDiscoverController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKDiscoverController: YKBaseCollectionViewController {
    fileprivate var cellArray: [YKDiscoverModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// 初始化cell
    func setupCell() {
        if self.title == nil {
            self.title = "附近"
        }
        cellArray.append(YKDiscoverModel(image: "Discover_cell0", title: "律师事务所"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell1", title: "律师"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell2", title: "公证处"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell3", title: "公证员"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell4", title: "人民调解委员会"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell5", title: "司法鉴定机构"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell6", title: "司法行政机构"))
        cellArray.append(YKDiscoverModel(image: "Discover_cell7", title: "基层法律服务所"))
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCell", for: indexPath) as! YKDiscoverCell
        cell.bindData(cellArray[indexPath.item])
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsID") as! YKDetailsController
        switch indexPath.item {
        case 0:
            vc.title = "律师事务所"
            vc.type = YKDetailsType.lssws
        case 1:
            vc.title = "律师"
            vc.type = YKDetailsType.ls
        case 2:
            vc.title = "公证处"
            vc.type = YKDetailsType.gzc
        case 3:
            vc.title = "公证员"
            vc.type = YKDetailsType.gzy
        case 4:
            vc.title = "人民调解委员会"
            vc.type = YKDetailsType.rmyyh
        case 5:
            vc.title = "司法鉴定机构"
            vc.type = YKDetailsType.sfjdjg
        case 6:
            vc.title = "司法行政机构"
            vc.type = YKDetailsType.sfxzjg
        case 7:
            vc.title = "基层法律服务所"
            vc.type = YKDetailsType.flfws
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0 , bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 2) / 3.0
        return CGSize(width:  width, height: 124)
    }
}
