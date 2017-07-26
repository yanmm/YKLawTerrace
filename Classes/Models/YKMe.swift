//
//  YKMe.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class YKUserInfo {
    var realname = ""
    var user_id: Int
    var figure_avatar = ""
    var username = ""
    
    init(json: JSON) {
        self.realname = json["realname"].stringValue
        self.user_id = json["user_id"].intValue
        self.figure_avatar = kAPI_HOST_HTTP + json["figure_avatar"].stringValue
        self.username = json["username"].stringValue
    }
}
