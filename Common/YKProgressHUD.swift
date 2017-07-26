//
//  YKProgressHUD.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

/// HUD延迟时间
public let kDuration_Of_HUD: Foundation.TimeInterval = 1.6 // Progress HUD 延迟时间
public let kDuration_Of_Animation: Foundation.TimeInterval = 0.25 // 动画的持续时间

class YKProgressHUD {
    static var lastHUD: MBProgressHUD? = nil
    
    class func showText(_ message: String, inView: UIView? = nil) {
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: false)
        }
        
        let inView = inView ?? topView()
        let HUD = MBProgressHUD(view: inView)
        HUD.mode = MBProgressHUDMode.text
        HUD.detailsLabel.text = message
        HUD.margin = 10.0
        //HUD.yOffset = inView.frame.size.height / 2.0 - 80.0
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        HUD.hide(animated: true, afterDelay: kDuration_Of_HUD)
    }
    
    class func showError(_ message: String?, inView: UIView? = nil) {
        let errorView = UIImageView(image: UIImage(named: "hud_error"))
        let HUD = show(inView, message: message, customView: errorView)
        HUD.hide(animated: true, afterDelay: kDuration_Of_HUD)
    }
    
    class func showSuccess(_ message: String?, inView: UIView? = nil, global: Bool = true) {
        let successView = UIImageView(image: UIImage(named: "hud_success"))
        let HUD = show(inView, message: message, customView: successView, global: global)
        HUD.hide(animated: true, afterDelay: kDuration_Of_HUD)
    }
    
    @discardableResult class func showHUD(_ message: String?, inView: UIView? = nil, global: Bool = true) -> MBProgressHUD {
        return show(inView, message: message, customView: nil, global: global)
    }
    
    class func showGif(_ message: String?, inView: UIView? = nil) {
        let successView = UIImageView(image: UIImage(named: "animation_open_red_envelope_1"))
        var images: [UIImage] = []
        for idx in 1...4 {
            if let image = UIImage(named: "animation_open_red_envelope_\(idx)") {
                images.append(image)
            }
        }
        successView.animationImages = images
        successView.animationDuration = 0.6
        successView.animationRepeatCount = 0
        successView.startAnimating()
        let HUD = show(inView, message: message, customView: successView)
        HUD.bezelView.color = UIColor.clear
        HUD.bezelView.style = .solidColor
        HUD.backgroundColor = UIColor(hex6: 0x111111, alpha: 0.2)
    }
    
    fileprivate class func show(_ inView: UIView?, message: String? = nil, customView: UIView? = nil, global: Bool = true) -> MBProgressHUD {
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: false)
        }
        
        let inView = inView ?? topView()
        let HUD = MBProgressHUD(view: inView)
        if let _ = customView {
            HUD.mode = MBProgressHUDMode.customView
        } else {
            HUD.mode = MBProgressHUDMode.indeterminate
        }
        
        HUD.customView = customView
        HUD.detailsLabel.text = message
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        if global {
            lastHUD = HUD
        }
        
        return HUD
    }
    
    /**
     关闭提示
     - parameter animated: 是否启用动画
     */
    class func hide(_ animated: Bool) {
        if let hud = lastHUD {
            hud.hide(animated: animated)
            lastHUD = nil
        }
    }
    
    fileprivate class func topView() -> UIView {
        return UIApplication.shared.keyWindow ?? UIView()
    }
}
