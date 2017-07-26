//
//  YKProgressHUD.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import Foundation

public let kHUD_GLOBAL_TAG = 10012
public let kHUD_INDEPENDENCE_TAG = 10011
class YKProgressHUD {
    static var lastHUD: MBProgressHUD? = nil
    
    /**
     出错提示
     - parameter message: 错误信息
     */
    class func popupError(_ message: String?, inView: UIView? = nil) {
        let errorView = UIImageView(image: UIImage(named: "hud_error"))
        let HUD = pop(inView ?? topView(), message: message, customView: errorView)
        HUD.hide(animated: true, afterDelay: kDelayTime_Of_HUD)
    }
    
    /**
     成功提示
     - parameter message: 成功信息
     */
    class func popupSuccess(_ message: String?, inView: UIView? = nil) {
        let successView = UIImageView(image: UIImage(named: "hud_success"))
        let HUD = pop(inView ?? topView(), message: message, customView: successView)
        HUD.hide(animated: true, afterDelay: kDelayTime_Of_HUD)
    }
    
    /**
     弹出过程提示
     - parameter message: 弹出过程信息
     */
    class func popup(_ message: String?, inView: UIView? = nil, global: Bool = true) -> MBProgressHUD {
        return pop(inView ?? topView(), message: message, customView: nil, global: global)
    }
    
    fileprivate class func pop(_ inView: UIView, message: String? = nil, customView: UIView? = nil, global: Bool = true) -> MBProgressHUD {
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: false)
        }
        
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
        
        HUD.tag = kHUD_INDEPENDENCE_TAG
        if global {
            lastHUD = HUD
            HUD.tag = kHUD_GLOBAL_TAG
        }
        
        return HUD
    }
    
    /**
     关闭提示
     - parameter animated: 是否启用动画
     */
    class func hide(_ animated: Bool) {
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: animated)
        }
        lastHUD = nil
    }
    
    /**
     隐藏View中的HUD（global的值为false才有用）
     */
    class func hide(_ inView: UIView) {
        for subview in inView.subviews.reversed() {
            if let hud = subview as? MBProgressHUD, hud.tag == kHUD_INDEPENDENCE_TAG {
                hud.hide(animated: true)
            }
        }
    }
    
    /**
     弹出Toast信息
     - parameter message: Toast信息
     */
    class func popToast(_ message: String, inView: UIView? = nil) {
        let inView = inView ?? topView()
        let HUD = MBProgressHUD(view: inView)
        
        HUD.mode = MBProgressHUDMode.text
        HUD.detailsLabel.text = message
        HUD.margin = 10.0
        //HUD.yOffset = inView.frame.size.height / 2.0 - 80.0
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        HUD.hide(animated: true, afterDelay: kDelayTime_Of_HUD)
    }
    
    //带背景颜色提示
    class func popToastWithColor(_ message: String, inView: UIView? = nil, withColor:UIColor? = nil) {
        let inView = inView ?? topView()
        let HUD = MBProgressHUD(view: inView)
        
        if let withColor = withColor {
            HUD.bezelView.color = withColor
        }
        HUD.mode = MBProgressHUDMode.text
        HUD.detailsLabel.text = message
        HUD.margin = 10.0
        //HUD.yOffset = inView.frame.size.height / 2.0 - 80.0
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        HUD.hide(animated: true, afterDelay: kDelayTime_Of_HUD)
    }
    
    /**
     上传图片进度提示信息
     - parameter message: 文本消息
     - parameter inView:  依附视图
     - returns: HUD
     */
    class func popupProgress(_ message: String, inView: UIView? = nil, global: Bool = true) -> MBProgressHUD {
        let inView = inView ?? topView()
        
        if let lastHUD = lastHUD {
            lastHUD.hide(animated: false)
        }
        
        let HUD = MBProgressHUD(view: inView)
        HUD.mode = MBProgressHUDMode.determinate
        //HUD.mode = MBProgressHUDMode.DeterminateHorizontalBar
        HUD.label.text = message
        HUD.removeFromSuperViewOnHide = true
        inView.addSubview(HUD)
        HUD.show(animated: true)
        
        HUD.tag = kHUD_INDEPENDENCE_TAG
        if global {
            lastHUD = HUD
            HUD.tag = kHUD_GLOBAL_TAG
        }
        
        return HUD
    }
    
    fileprivate class func topView() -> UIView {
        if let topView = UIApplication.shared.keyWindow?.subviews.first {
            return topView
        }
        if let topView = UIApplication.shared.windows.first?.subviews.first {
            return topView
        }
        return UIView()
    }
}
