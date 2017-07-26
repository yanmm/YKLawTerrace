//
//  YKHttpClient+Me.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

extension YKHttpClient {
    /// 公证申请第一步
    func notaryApplyOne(_ apply_name: String?, apply_gender: String?, apply_birthday: String?, apply_IDcard_no: String?, apply_workunit: String?, apply_cellphone: String?, agent_name: String?, agent_workunit: String?, agent_IDcard_no: String?, apply_relations: String?, agent_cellphone: String?, completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters: NSMutableDictionary = ["step": 1,
                                               "token": YKUser.shared.token,
                                               "userid": YKUser.shared.userid]
        if let apply_name = apply_name {
            parameters["apply_name"] = apply_name
        }
        if let apply_gender = apply_gender {
            parameters["apply_gender"] = apply_gender
        }
        if let apply_birthday = apply_birthday {
            parameters["apply_birthday"] = apply_birthday
        }
        if let apply_IDcard_no = apply_IDcard_no {
            parameters["apply_IDcard_no"] = apply_IDcard_no
        }
        if let apply_workunit = apply_workunit {
            parameters["apply_workunit"] = apply_workunit
        }
        if let apply_cellphone = apply_cellphone {
            parameters["apply_cellphone"] = apply_cellphone
        }
        if let agent_name = agent_name {
            parameters["agent_name"] = agent_name
        }
        if let agent_workunit = agent_workunit {
            parameters["agent_workunit"] = agent_workunit
        }
        if let agent_IDcard_no = agent_IDcard_no {
            parameters["agent_IDcard_no"] = agent_IDcard_no
        }
        if let apply_relations = apply_relations {
            parameters["apply_relations"] = apply_relations
        }
        if let agent_cellphone = agent_cellphone {
            parameters["agent_cellphone"] = agent_cellphone
        }
            
        post("/api/service/notaryApply", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let new = responseObject["responseData"] as? [String : Any] {
                    if let count = new["\("notary_id")"] as? String, let id = Int(count) {
                        completionHandler(id, nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 公证申请第二步
    func notaryApplyTwo(_ notary_id: Int, with_notary_items: String, submit_stuff1: String, with_use_place: String, submit_stuff: [String], attachment: [UIImage],  completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters = ["step": 2,
                          "notary_id": notary_id,
                          "with_notary_items": with_notary_items,
                          "submit_stuff1": submit_stuff1,
                          "with_use_place": with_use_place,
                          "submit_stuff": submit_stuff,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/notaryApply", parameters: parameters, constructingBodyWith: { (formData) in
            for (i, image) in attachment.enumerated() {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHHmmss"
                    let fileName = formatter.string(from: Date()) + "\(i).jpg"
                    formData.appendPart(withFileData: imageData, name: "attachment", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            }, progress: nil, success: { (_, responseObject) in
                if let responseObject = responseObject as? [String : Any] {
                    if let new = responseObject["responseData"] as? [String : Any] {
                        if let count = new["\("notary_id")"] as? String, let id = Int(count) {
                            completionHandler(id, nil)
                        }
                    }
                }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 公证申请第三步
    func notaryApplyThree(_ notary_id: Int, refer_translation: String, explain_content: String, data: String, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["step": 3,
                          "notary_id": notary_id,
                          "refer_translation": refer_translation,
                          "explain_content": explain_content,
                          "data": data,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/notaryApply", parameters: parameters, progress: nil, success: { (_, responseObject) in
            completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 法律援助第一步
    func lawAssistOne(_ applicant: String, gender: String, birthday: String, nation: String, legal_person: String?, IDcard_no: String, domicile_place: String, cellphone: String, workunit: String, home_place: String, postcode: String, edu_level: String, physical_state: String, completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters: NSMutableDictionary = ["step": 1,
                                               "applicant": applicant,
                                               "gender": gender,
                                               "birthday": birthday,
                                               "nation": nation,
                                               "IDcard_no": IDcard_no,
                                               "domicile_place": domicile_place,
                                               "cellphone": cellphone,
                                               "workunit": workunit,
                                               "home_place": home_place,
                                               "postcode": postcode,
                                               "edu_level": edu_level,
                                               "physical_state": physical_state,
                                               "token": YKUser.shared.token,
                                               "userid": YKUser.shared.userid]
        if let legal_person = legal_person {
            parameters["legal_person"] = legal_person
        }
        post("/api/service/lawAssist", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let new = responseObject["responseData"] as? [String : Any] {
                    if let count = new["\("assist_id")"] as? String, let id = Int(count) {
                        completionHandler(id, nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律援助第二步
    func lawAssistTwo(_ assist_id: Int, crowd_cate: [String], assist_cate: [String], completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters = ["step": 2,
                          "assist_id": assist_id,
                          "crowd_cate": crowd_cate,
                          "assist_cate": assist_cate,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/lawAssist", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let new = responseObject["responseData"] as? [String : Any] {
                    if let count = new["\("assist_id")"] as? String, let id = Int(count) {
                        completionHandler(id, nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律援助第三步
    func lawAssistThree(_ assist_id: Int, legalcase_cate: String, legalcase_role: String, completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters = ["step": 3,
                          "assist_id": assist_id,
                          "legalcase_cate": legalcase_cate,
                          "legalcase_role": legalcase_role,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/lawAssist", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let new = responseObject["responseData"] as? [String : Any] {
                    if let count = new["\("assist_id")"] as? String, let id = Int(count) {
                        completionHandler(id, nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律援助第四步
    func lawAssistFour(_ assist_id: Int, legalcase_state: String, legalcase_mode: String, profession_income: String, benefits: String, family_nums: String, average_income: String, basic_expense: String, completionHandler:@escaping (Int?, NSError?) -> Void) {
        let parameters = ["step": 4,
                          "assist_id": assist_id,
                          "legalcase_state": legalcase_state,
                          "legalcase_mode": legalcase_mode,
                          "profession_income": profession_income,
                          "benefits": benefits,
                          "family_nums": family_nums,
                          "average_income": average_income,
                          "basic_expense": basic_expense,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/lawAssist", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let new = responseObject["responseData"] as? [String : Any] {
                    if let count = new["\("assist_id")"] as? String, let id = Int(count) {
                        completionHandler(id, nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
    
    /// 法律援助第五步
    func lawAssistFive(_ assist_id: Int, economic_amount: String, build_size: String, build_use_state: String, case_intro: String, completionHandler:@escaping (NSError?) -> Void) {
        let parameters = ["step": 5,
                          "assist_id": assist_id,
                          "economic_amount": economic_amount,
                          "build_size": build_size,
                          "build_use_state": build_use_state,
                          "case_intro": case_intro,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/service/lawAssist", parameters: parameters, progress: nil, success: { (_, responseObject) in
            completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 修改用户信息
    func updateUser(_ realname: String?, avatar: UIImage?, completionHandler:@escaping (NSError?) -> Void) {
        let parameters: NSMutableDictionary = ["token": YKUser.shared.token,
                                               "userid": YKUser.shared.userid]
        if let realname = realname {
            parameters["realname"] = realname
        }
        post("/api/user/updateUser", parameters: parameters, constructingBodyWith: { (formData) in
            if let image = avatar {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHHmmss"
                    let fileName = formatter.string(from: Date()) + ".jpg"
                    formData.appendPart(withFileData: imageData, name: "avatar", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            }, progress: nil, success: { (_, responseObject) in
                completionHandler(nil)
        }) { (_, error) -> Void in
            completionHandler(error as NSError)
        }
    }
    
    /// 获取用户信息
    func userinfo(_ customerid: String, completionHandler:@escaping (YKUserInfo?, NSError?) -> Void) {
        let parameters = ["customerid": customerid,
                          "token": YKUser.shared.token,
                          "userid": YKUser.shared.userid] as [String : Any]
        post("/api/user/userinfo", parameters: parameters, progress: nil, success: { (_, responseObject) in
            if let responseObject = responseObject as? [String : Any] {
                if let data = responseObject["responseData"] as? NSDictionary {
                    if let userinfo = data["userinfo"] as? NSDictionary {
                        completionHandler(YKUserInfo(json: JSON(userinfo)), nil)
                    }
                }
            }
        }) { (_, error) -> Void in
            completionHandler(nil, error as NSError)
        }
    }
}
