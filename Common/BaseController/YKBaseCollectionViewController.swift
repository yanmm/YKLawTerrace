//
//  YKBaseCollectionViewController.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class YKBaseCollectionViewController: UICollectionViewController {

    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
