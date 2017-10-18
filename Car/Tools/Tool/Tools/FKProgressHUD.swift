//
//  FKProgressHUD.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/25.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

/**
 //显示
 HUD.center.loading("请稍等...", addView: view)
 HUD.bottom.tip("请收拾好行李")
 //隐藏
 HUD.center.hide()
 */

class HUD {

    static let center = HUD()
    static let bottom = HUD()
    
    //hud先只创建4种样式1，loadingCenterView
    var hud: MBProgressHUD?
    
    func loading(_ message: String, addView: UIView = (UIApplication.shared.keyWindow)!) {
        if (HUD.center.hud != nil) {
            HUD.center.hide()
        }
        hud = MBProgressHUD.showAdded(to:addView, animated: true)
        hud?.bezelView.color = UIColor.init(red: 6/255.0, green: 68/255.0, blue: 123/255.0, alpha: 1)
        hud?.contentColor = UIColor.white
        hud?.label.textColor = UIColor.white
        hud?.isUserInteractionEnabled = false
        hud?.label.text = message
        hud?.hide(animated: true, afterDelay: 15)
    }
    
    func tip(_ message: String, addView: UIView = (UIApplication.shared.keyWindow)!, offset: Int = 60 + Int(StatusHeight())) {
        hud = MBProgressHUD.showAdded(to:addView, animated: true)
        hud?.mode = .text
        hud?.offset = CGPoint(x:0,y:Int(SCREEN_HEIGHT()/2) - offset)
        hud?.label.text = message
        hud?.label.font = UIFont.systemFont(ofSize: 13.0)
        hud?.contentColor = UIColor.white
        hud?.bezelView.color = UIColor.black
        hud?.bezelView.layer.cornerRadius = 7
        hud?.margin = 5
        hud?.isUserInteractionEnabled = false
        hud?.hide(animated: true, afterDelay: 3)
    }
    
    
    func hide() {
        hud?.hide(animated: true)
        hud = nil
    }
}
