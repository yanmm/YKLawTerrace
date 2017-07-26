//
//  YKWork.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class WEYNewsList {
    var content = ""
    var create_time: Int
    var id: Int
    var title = ""
    var publish_from = ""
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.publish_from = json["publish_from"].stringValue
        self.id = json["id"].intValue
        self.create_time = json["create_time"].intValue
        self.content = json["content"].stringValue
    }
}
