//
//  YKProtolController.swift
//  YKProject
//
//  Created by Yuki on 16/10/23.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKProtolController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isEditable = false
        textView.scrollRangeToVisible(NSRange(location: 0, length: 1))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textView.scrollRangeToVisible(NSRange(location: 0, length: 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
