//
//  YKAboutController.swift
//  YKProject
//
//  Created by Yuki on 2016/11/3.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKAboutController: YKBaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            titleLabel.text = "版本号 " + versionString
        }
        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            nameLabel.text = name
        }
    }
    
    @IBAction func gotoProtol(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YKLogin", bundle: nil).instantiateViewController(withIdentifier: "ProtolID") as! YKProtolController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
