//
//  YKHomeController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/1.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKHomeController: YKBaseViewController {
    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cellOne: IBDesigbableView!
    @IBOutlet weak var cellTwo: IBDesigbableView!
    @IBOutlet weak var cellThree: IBDesigbableView!
    @IBOutlet weak var cellFour: IBDesigbableView!
    @IBOutlet weak var cellFive: IBDesigbableView!
    @IBOutlet weak var cellSix: IBDesigbableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    /// 初始化
    func setupView() {
        bgViewWidth.constant = kScreenWidth
        bgViewHeight.constant = kScreenHeight - 20
        
        cellOne.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).cgColor
        cellOne.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellOne.layer.shadowOpacity = 1
        cellOne.clipsToBounds = false
        
        cellTwo.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).cgColor
        cellTwo.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellTwo.layer.shadowOpacity = 1
        cellTwo.clipsToBounds = false
        
        cellThree.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).cgColor
        cellThree.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellThree.layer.shadowOpacity = 1
        cellThree.clipsToBounds = false
        
        cellFour.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).cgColor
        cellFour.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellFour.layer.shadowOpacity = 1
        cellFour.clipsToBounds = false
        
        cellFive.layer.shadowColor = UIColor(white: 000000, alpha: 0.3).cgColor
        cellFive.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellFive.layer.shadowOpacity = 1
        cellFive.clipsToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// 工作动态
    @IBAction func cellOneClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKDynamic", bundle: nil).instantiateViewController(withIdentifier: "DynamicID") as! YKDynamicController
        vc.title = "工作动态"
        vc.type = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 办事指南
    @IBAction func cellTwoClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKDynamic", bundle: nil).instantiateViewController(withIdentifier: "DynamicID") as! YKDynamicController
        vc.title = "办事指南"
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 信息查询
    @IBAction func cellThreeClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKDiscover", bundle: nil).instantiateViewController(withIdentifier: "DiscoverID") as! YKDiscoverController
        vc.title = "信息查询"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 法律法规
    @IBAction func cellFourClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKDynamic", bundle: nil).instantiateViewController(withIdentifier: "DynamicID") as! YKDynamicController
        vc.title = "法律法规"
        vc.type = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 法制宣传
    @IBAction func cellFiveClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKDynamic", bundle: nil).instantiateViewController(withIdentifier: "DynamicID") as! YKDynamicController
        vc.title = "法制宣传"
        vc.type = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
