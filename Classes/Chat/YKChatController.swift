//
//  YKChatController.swift
//  YKProject
//
//  Created by Yuki on 2016/10/12.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKChatController: RCConversationViewController {
    var chatModel: RCConversationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 如果是单聊，不显示发送方昵称
        if self.conversationType == RCConversationType.ConversationType_PRIVATE {
            self.displayUserNameInCell = false
        } else {
            self.displayUserNameInCell = true
        }
        if RCIM.shared() != nil {
            RCIM.shared().currentUserInfo = RCUserInfo(userId: "\(YKUser.shared.IMUserID)", name: YKUser.shared.nickname, portrait: YKUser.shared.avatar)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init!(conversationType: RCConversationType, targetId: String!) {
        super.init(conversationType: conversationType, targetId: targetId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didTapMessageCell(_ model: RCMessageModel!) {
        super.didTapMessageCell(model)
    }
    
    override func didLongTouchMessageCell(_ model: RCMessageModel!, in view: UIView!) {
//        super.didLongTouchMessageCell(model, inView: view)
    }
    
    override func didTapUrl(inMessageCell url: String!, model: RCMessageModel!) {
//        super.didTapUrlInMessageCell(url, model: model)
    }
    
    override func didTapCellPortrait(_ userId: String!) {
//        super.didTapCellPortrait(userId)
    }
    
    override func didLongPressCellPortrait(_ userId: String!) {
//        super.didLongPressCellPortrait(userId)
    }
    
    override func deleteMessage(_ model: RCMessageModel!) {
//        super.deleteMessage(model)
//        self.view.layoutSubviews()
    }
    
    /// YKGroupInfoDelegate
    func changeName(_ name: String) {
        self.title = name
    }
}
