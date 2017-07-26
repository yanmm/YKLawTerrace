//
//  YKAlertView.swift
//  WEYBee
//
//  Created by Yuki on 16/4/15.
//  Copyright © 2016年 Zhejiang YaoWang Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// AlertView类型
public enum YKAlertViewStyle: Int {
    case actionSheet
    case alert
    case actionTop
}

/// 添加的按钮类型
public enum YKButtonStyle: Int {
    case normal
    /// 在Alert中与Cancel类型不会显示在视图上，在ActionSheet会在底层显示，且只有一个
    case cancel
}

/// 添加的按钮颜色
public enum YKButtonColor: Int {
    case normal
    case `super`
}

struct YKButton {
    var title: String!
    var style: YKButtonStyle!
    var color: YKButtonColor!
    var handler: (() -> Void)? = nil
    var completion: (() -> Void)? = nil
    
    init(title: String, style: YKButtonStyle, color: YKButtonColor, handler: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.color = color
        self.handler = handler
        self.completion = completion
    }
}

class YKAlertView: UIView {
    /**********         ActionSheet          ******/
    
    /// 粗线条高度
    fileprivate let blodLineHeight: CGFloat = 10.0
    /// 粗线条颜色（返回上面）
    fileprivate let blodLineColor = UIColor(hex6: 0xE7E7F1)
    
    /**********         ActionTop          ******/
    
    /// 计时器
    fileprivate var timer = Timer()
    /// 显示时间
    fileprivate let showTime: Double = 2
    /// ActionTop点击背景回调
    var actionTopCompletion: (() -> Void)? = nil
    /// ActionTop背景颜色
    var actionTopViewColor = UIColor(hex6: 0xFD836A)
    /// ActionTop文字颜色
    var actionTopTitleColor = UIColor(hex6: 0xFFFFFF)
    
    
    /**********           Alert              ******/
    
    /// 内容视图宽度
    fileprivate let viewWidth: CGFloat = 270
    /// 标题间距
    fileprivate let titleInset: CGFloat = 20
    /// mwssage内容上下间距
    fileprivate let messageTopInset: CGFloat = 10
    /// mwssage内容左右间距
    fileprivate let messageLeftInset: CGFloat = 15
    /// 最大高度
    fileprivate let MLFLOAT_MAX: CGFloat = 350.0
    
    
    /**********      Alert && ActionSheet && ActionTop      ******/
    
    /// 屏幕宽度
    fileprivate let kWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    fileprivate let kHeight = UIScreen.main.bounds.height
    /// 内容视图高度
    fileprivate var viewHeight: CGFloat = 0
    /// 返回按钮高度
    fileprivate var cancelBtnHeight: CGFloat = 50.0
    /// 普通按钮高度
    fileprivate var actionBtnHeight: CGFloat = 50.0
    /// 标题按钮高度
    fileprivate var titleHeight: CGFloat = 35.0
    /// 动画时长
    fileprivate let animationTime = 0.3
    /// 背景遮罩透明度
    fileprivate let bgAlpha: CGFloat = 0.3
    /// 内容视图
    fileprivate lazy var contentView = UIView()
    /// 背景遮罩
    fileprivate lazy var bgBtn = UIButton(type: UIButtonType.custom)
    /// 线条数量
    fileprivate var lineNum: Int = 0
    /// 普通按钮
    fileprivate lazy var normalBtns: [YKButton] = []
    /// 返回按钮
    fileprivate var cancelBtn: YKButton!
    /// 细线条颜色
    fileprivate var smallLineColor = UIColor(hex6: 0xE5E5E5)
    /// 普通按钮颜色
    fileprivate var normolColor = UIColor(hex6: 0x222222)
    /// 返回按钮颜色
    fileprivate var cancelColor = UIColor(hex6: 0x222222)
    /// 标题按钮颜色
    fileprivate var titleColor = UIColor(hex6: 0x222222)
    /// 提示标题
    var title: String!
    /// 提示内容（如果是ActionSheet不会显示）
    var message: String!
    /// 类型
    var style: YKAlertViewStyle! {
        didSet {
            cancelBtnHeight = style == .actionSheet ? 50.0 : 44.0
            actionBtnHeight = style == .actionSheet ? 50.0 : 44.0
            contentView.layer.cornerRadius = style == .alert ? 10 : 0
            contentView.backgroundColor = style == .alert ? UIColor.white : UIColor.clear
            titleHeight = style == .actionSheet ? 35.0 : 21.0
            smallLineColor = style == .actionSheet ? UIColor(hex6: 0xE5E5E5) : UIColor(hex6: 0xD4D4D4)
            titleColor = style == .actionSheet ? UIColor(hex6: 0x222222) : UIColor(hex6: 0x030303)
            normolColor = style == .actionSheet ? UIColor(hex6: 0x222222) : UIColor(hex6: 0x030303)
            cancelColor = style == .actionSheet ? UIColor(hex6: 0x222222) : UIColor(hex6: 0x030303)
            contentView.clipsToBounds = true
        }
    }
    /// 特殊按钮颜色
    var superColor = UIColor(hex6: 0xFD836A)
    /// 点击按钮之后是否隐藏视图
    var shouldRemoveView = true
    
    /// 初始化方法
    class func initView(_ title: String?, message: String?, style: YKAlertViewStyle) -> YKAlertView {
        let view = YKAlertView()
        if style == .actionTop {
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        } else {
            view.frame = UIScreen.main.bounds
        }
        view.title = title
        view.message = message
        view.style = style
        return view
    }
    
    /// 添加按钮
    func addButton(_ title: String, style: YKButtonStyle, color: YKButtonColor, handler: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let btn = YKButton(title: title, style: style, color: color, handler: handler, completion: completion)
        if btn.style == .cancel {
            self.cancelBtn = btn
            return
        }
        self.normalBtns.append(btn)
    }
    
    /// 初始化ActionSheet视图
    fileprivate func setupActionSheet() {
        if title == nil {
            viewHeight = CGFloat(normalBtns.count) * actionBtnHeight
            if self.cancelBtn != nil {
                self.viewHeight += (cancelBtnHeight + blodLineHeight)
            }
        } else {
            viewHeight = CGFloat(normalBtns.count) * actionBtnHeight + titleHeight
            if self.cancelBtn != nil {
                self.viewHeight += (cancelBtnHeight + blodLineHeight)
            }
            lineNum += 1
        }
        
        bgBtn.backgroundColor = UIColor.black.withAlphaComponent(0)
        bgBtn.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside)
        self.addSubview(bgBtn)
        bgBtn.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(viewHeight)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(viewHeight)
        }
        
        if self.cancelBtn != nil {
            let cancelBtn = UIButton(type: UIButtonType.custom)
            let color = self.cancelBtn.color == .normal ? cancelColor : superColor
            cancelBtn.setTitleColor(color, for: UIControlState())
            cancelBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Medium"))
            cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            cancelBtn.backgroundColor = UIColor.white
            contentView.addSubview(cancelBtn)
            cancelBtn.tag = -1
            cancelBtn.setTitle(self.cancelBtn.title, for: UIControlState())
            cancelBtn.addTarget(self, action: #selector(actionBtnClick(_:)), for: UIControlEvents.touchUpInside)
            cancelBtn.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(cancelBtnHeight)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
            }
        }
        
        for (index, btn) in normalBtns.enumerated().reversed() {
            let actionBtn = UIButton(type: UIButtonType.custom)
            actionBtn.tag = index
            actionBtn.backgroundColor = UIColor.white
            actionBtn.setTitle(btn.title, for: UIControlState())
            let color = btn.color == .normal ? cancelColor : superColor
            actionBtn.setTitleColor(color, for: UIControlState())
            actionBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Medium"))
            actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            actionBtn.addTarget(self, action: #selector(actionBtnClick(_:)), for: UIControlEvents.touchUpInside)
            contentView.addSubview(actionBtn)
            actionBtn.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(actionBtnHeight)
                make.left.equalTo(0)
                make.right.equalTo(0)
                if self.cancelBtn != nil {
                    make.bottom.equalTo(-(CGFloat(normalBtns.count - index - 1) * actionBtnHeight + cancelBtnHeight + blodLineHeight))
                } else {
                    make.bottom.equalTo(-(CGFloat(normalBtns.count - index - 1) * actionBtnHeight))
                }
                
            }
            lineNum += 1
        }
        
        if let title = title {
            let titleBtn = UIButton(type: UIButtonType.custom)
            titleBtn.setTitleColor(titleColor, for: UIControlState())
            titleBtn.backgroundColor = UIColor.white
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            contentView.addSubview(titleBtn)
            titleBtn.setTitle(title, for: UIControlState())
            titleBtn.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(titleHeight)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
            }
        }
        
        while lineNum > 0 {
            let line = UIView()
            if lineNum == 1 && self.cancelBtn != nil {
                line.backgroundColor = blodLineColor
                contentView.addSubview(line)
                line.snp.makeConstraints { (make) -> Void in
                    make.height.equalTo(blodLineHeight)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    if cancelBtn != nil {
                        make.bottom.equalTo(-(CGFloat(lineNum - 1) * actionBtnHeight + cancelBtnHeight))
                    } else {
                        make.bottom.equalTo(-(CGFloat(lineNum - 1) * actionBtnHeight))
                    }
                    
                }
            } else {
                line.backgroundColor = smallLineColor
                contentView.addSubview(line)
                line.snp.makeConstraints { (make) -> Void in
                    make.height.equalTo(0.5)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                    if self.cancelBtn != nil {
                        make.bottom.equalTo(-(CGFloat(lineNum - 1) * actionBtnHeight + cancelBtnHeight + blodLineHeight))
                    } else {
                        make.bottom.equalTo(-(CGFloat(lineNum - 1) * actionBtnHeight))
                    }
                }
            }
            lineNum -= 1
        }
    }
    
    /// 初始化Alert视图
    fileprivate func setupAlert() {
        if title != nil {
            viewHeight += (titleInset + titleHeight)
        }
        if message != nil {
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 13.0)
            label.numberOfLines = 0
            let size = label.sizeThatFits(CGSize(width: viewWidth - 2 * messageLeftInset, height: MLFLOAT_MAX))
            viewHeight += (messageTopInset * 2 + size.height)
        }
        viewHeight += actionBtnHeight
        
        bgBtn.backgroundColor = UIColor.black.withAlphaComponent(0)
        bgBtn.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside)
        self.addSubview(bgBtn)
        bgBtn.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        
        contentView.alpha = 0
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center).offset(0)
            make.height.equalTo(viewHeight)
            make.width.equalTo(viewWidth)
        }
        
        if let title = self.title {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = titleColor
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Medium"))
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(titleHeight)
                make.left.equalTo(titleInset)
                make.right.equalTo(-titleInset)
                make.top.equalTo(titleInset)
            }
        }
        
        if let message = self.message {
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.textColor = normolColor
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.font = UIFont.systemFont(ofSize: 13)
            contentView.addSubview(messageLabel)
            messageLabel.snp.makeConstraints { (make) -> Void in
                if self.title != nil {
                    make.top.equalTo(titleHeight + titleInset + messageTopInset)
                } else {
                    make.top.equalTo(messageTopInset)
                }
                make.left.equalTo(messageLeftInset)
                make.right.equalTo(-messageLeftInset)
            }
        }
        
        if message != nil || title != nil {
            let line = UIView()
            line.backgroundColor = smallLineColor
            contentView.addSubview(line)
            line.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(0.5)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(-actionBtnHeight)
            }
        }
        
        for (index, btn) in normalBtns.enumerated() {
            let actionBtn = UIButton(type: UIButtonType.custom)
            actionBtn.tag = index
            actionBtn.backgroundColor = UIColor.white
            actionBtn.setTitle(btn.title, for: UIControlState())
            let color = btn.color == .normal ? cancelColor : superColor
            actionBtn.setTitleColor(color, for: UIControlState())
            actionBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Medium"))
            actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            actionBtn.addTarget(self, action: #selector(actionBtnClick), for: UIControlEvents.touchUpInside)
            contentView.addSubview(actionBtn)
            actionBtn.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(actionBtnHeight)
                make.width.equalTo(viewWidth / CGFloat(normalBtns.count))
                make.left.equalTo(CGFloat(index) * viewWidth / CGFloat(normalBtns.count))
                make.bottom.equalTo(0)
            }
            lineNum += 1
        }
        
        lineNum -= 1
        while lineNum > 0 {
            let line = UIView()
            line.backgroundColor = smallLineColor
            contentView.addSubview(line)
            line.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(0.5)
                make.height.equalTo(actionBtnHeight)
                make.left.equalTo(CGFloat(lineNum) * viewWidth / CGFloat(normalBtns.count))
                make.bottom.equalTo(0)
            }
            lineNum -= 1
        }
    }
    
    /// 初始化ActionTop视图
    fileprivate func setupActionTop() {
        viewHeight = 64
        
        self.addSubview(contentView)
        contentView.backgroundColor = actionTopViewColor
        contentView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(viewHeight)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(-viewHeight)
        }
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.numberOfLines = 2
        messageLabel.textColor = actionTopTitleColor
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            // top应该是20的  可15效果好点
            make.top.equalTo(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        }
        
        let actionBtn = UIButton()
        contentView.addSubview(actionBtn)
        actionBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        actionBtn.addTarget(self, action: #selector(actionTopViewClick), for: UIControlEvents.touchUpInside)
    }
    
    /// 显示视图
    func showView() {
        if style == .actionSheet {
            setupActionSheet()
        }
        if style == .alert {
            setupAlert()
        }
        if style == .actionTop {
            setupActionTop()
        }
        
        UIApplication.shared.keyWindow!.addSubview(self)
        UIView.animate(withDuration: animationTime, animations: {
            if self.style == .actionSheet {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.viewHeight)
            }
            if self.style == .actionTop {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: self.viewHeight)
                self.timer = Timer.scheduledTimer(timeInterval: self.showTime, target: self, selector: #selector(self.dismissView), userInfo: nil, repeats: false)
                return
            }
            if self.style == .alert {
                self.contentView.alpha = 1
            }
            self.bgBtn.backgroundColor = UIColor.black.withAlphaComponent(self.bgAlpha)
        }) 
    }
    
    @objc fileprivate func actionTopViewClick() {
        if let handler = self.actionTopCompletion {
            handler()
        }
        self.dismissView()
    }
    
    @objc fileprivate func dismissView() {
        // Alert点击背景视图不会隐藏
        if style == .alert {
            return
        }
        UIView.animate(withDuration: animationTime, animations: {
            if self.style == .alert {
                self.contentView.alpha = 0
            } else {
                self.contentView.transform = CGAffineTransform.identity
            }
            self.bgBtn.backgroundColor = UIColor.black.withAlphaComponent(0)
            }, completion: { (_) in
                self.timer.invalidate()
                self.removeFromSuperview()
        }) 
    }
    
    @objc fileprivate func actionBtnClick(_ sender: UIButton) {
        // tag == -1 ActionSheet的返回按钮点击事件
        if sender.tag == -1 {
            if let handler = self.cancelBtn.handler {
                handler()
            }
        } else {
            if let handler = self.normalBtns[sender.tag].handler {
                handler()
            }
        }
        if !shouldRemoveView {
            return
        }
        UIView.animate(withDuration: animationTime, animations: {
            self.bgBtn.backgroundColor = UIColor.black.withAlphaComponent(0)
            if self.style == .actionSheet {
                self.contentView.transform = CGAffineTransform.identity
            } else {
                self.contentView.alpha = 0
            }
        }, completion: { (_) in
            if sender.tag == -1 {
                if let completion = self.cancelBtn.completion {
                    completion()
                }
            } else {
                if let completion = self.normalBtns[sender.tag].completion {
                    completion()
                }
            }
            self.removeFromSuperview()
        }) 
    }
}
