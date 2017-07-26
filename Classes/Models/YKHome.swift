//
//  YKHome.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class YKIMToken {
    var token = ""
    var userId: Int
    
    init(json: JSON) {
        self.token = json["_token"].stringValue
        self.userId = json["_userId"].intValue
    }
}
