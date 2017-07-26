//
//  YKChatListController.swift
//  YKProject
//
//  Created by Yuki on 2016/10/11.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKChatListController: RCConversationListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conversationListTableView.separatorColor = UIColor(hex6: 0xE9E9E9)
        self.conversationListTableView.backgroundColor = UIColor(hex6: 0xF2F2F2)
        self.conversationListTableView.tableFooterView = UIView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue,
            RCConversationType.ConversationType_DISCUSSION.rawValue,
            RCConversationType.ConversationType_CHATROOM.rawValue,
            RCConversationType.ConversationType_GROUP.rawValue,
            RCConversationType.ConversationType_APPSERVICE.rawValue,
            RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue])
    }
    
    override func willDisplayConversationTableCell(_ cell: RCConversationBaseCell!, at indexPath: IndexPath!) {
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //重写RCConversationListViewController的onSelectedTableRow事件
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        if let chat = YKChatController(conversationType: model.conversationType, targetId: "\(model.targetId)") {
            chat.title = model.conversationTitle
            self.navigationController?.pushViewController(chat, animated: true)
        }
    }
}
