//
//  YKDiscover.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

class WEYLawfirm {
    var address = ""
    var agency_certified_no = ""
    var agency_image = ""
    var agency_name = ""
    var contact = ""
    var latitude: Double
    var longitude: Double
    
    init(json: JSON) {
        self.address = json["address"].stringValue
        self.agency_certified_no = json["agency_certified_no"].stringValue
        self.agency_image = kAPI_HOST_HTTP + json["agency_image"].stringValue
        self.agency_name = json["agency_name"].stringValue
        self.contact = json["contact"].stringValue
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
    }
}

class WEYLawers {
    var agency_name = ""
    var engage_service = ""
    var figure_avatar = ""
    var user_id: Int
    var username = ""
    var realname = ""
    
    init(json: JSON) {
        self.agency_name = json["agency_name"].stringValue
        self.engage_service = json["engage_service"].stringValue
        self.figure_avatar = kAPI_HOST_HTTP + json["figure_avatar"].stringValue
        self.agency_name = json["agency_name"].stringValue
        self.user_id = json["user_id"].intValue
        self.username = json["username"].stringValue
        self.realname = json["realname"].stringValue
    }
}
