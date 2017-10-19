//
//  FKBaseDefaultView.swift
//  FlycoSmart
//
//  Created by hss on 2017/10/17.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

let kDefaultMessageKey     = "message"
let kDefaultBackColorKey   = "backColor"
let kDefaultTextColor      = "textColor"
let kDefaultButtonTitle    = "title"

class FKBaseDefaultView: NSObject{
    
    var completeAction:  (() -> Void)? = nil
    
    func defaultView(addToView: UIView ,info: [String:Any], complete: @escaping () -> Void) -> UIView {
        
        completeAction = complete
        
        let defaultView = UIView.init(frame: fk_Rect(0, 0, SCREEN_WIDTH(), 200))
        defaultView.center = fk_Point(addToView.bounds.size.width/2, addToView.bounds.size.height/2)
        defaultView.backgroundColor = info[kDefaultBackColorKey] as? UIColor
        
        let attentionLabel = UILabel.init(frame: fk_Rect(0, (defaultView.bounds.height)/2 - 30, SCREEN_WIDTH() - 40, 20))
        attentionLabel.textAlignment = .center
        attentionLabel.center = fk_Point((defaultView.bounds.width)/2, (defaultView.bounds.height)/2 - 20)
        attentionLabel.font = UIFont.systemFont(ofSize: 14.0)
        attentionLabel.text = info[kDefaultMessageKey] as? String
        attentionLabel.textColor = info[kDefaultTextColor] as? UIColor
        defaultView.addSubview(attentionLabel)
        
        let reloadButton = UIButton.init(type: .custom)
        reloadButton.frame = fk_Rect(0, 0, SCREEN_WIDTH()-80, 40)
        reloadButton.center = fk_Point((defaultView.bounds.width)/2, (defaultView.bounds.height)/2 + 30)
        reloadButton.layer.cornerRadius = reloadButton.bounds.height/2
        reloadButton.layer.masksToBounds = true
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        reloadButton.ts_setBackgroundColor(fkNaviColor(alpha: 0.7), forState: .normal)
        reloadButton.setTitleColor(UIColor.white, for: .normal)
        reloadButton.setTitle(info[kDefaultButtonTitle] as? String, for: .normal)
        reloadButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        defaultView.addSubview(reloadButton)
        
        return defaultView
    }
    
    @objc func refreshAction() {
        if completeAction != nil {
            completeAction!()
        }
    }
    
    
    func emptyView(addToView: UIView ,emptyMessage: String, emptyImageName: String) -> UIView {
        
        let emptyView = UIView.init(frame: fk_Rect(0, 0, SCREEN_WIDTH(), 200))
        emptyView.center = fk_Point(addToView.bounds.size.width/2, addToView.bounds.size.height/2 - 80)
        
        //image
        let emptyImageView = UIImageView.init(frame: fk_Rect(0, 0, 100, 100))
        emptyImageView.center = fk_Point((emptyView.bounds.width)/2, (emptyView.bounds.height)/2 - 40)
        emptyImageView.image = UIImage(named:emptyImageName)
        emptyView.addSubview(emptyImageView)
        
        let emptyMessageLabel = UILabel.init(frame: fk_Rect(0, 0, (emptyView.bounds.width), 30))
        emptyMessageLabel.center = fk_Point((emptyView.bounds.width)/2, (emptyView.bounds.height)/2 + 30)
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.textColor = UIColor.darkGray
        emptyMessageLabel.text = emptyMessage
        emptyView.addSubview(emptyMessageLabel)
        
        return emptyView
    }
    
    func activityView(addToView: UIView) -> UIView {
        
        let activityView = UIView.init(frame: CGRect(x:0,y:0,width:100,height:100))
        activityView.center = fk_Point(addToView.bounds.size.width/2, addToView.bounds.size.height/2)
        
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        activity.center = CGPoint(x:(activityView.frame.width)/2,y:(activityView.frame.height)/2 - 15)
        activity.startAnimating()
        activityView.addSubview(activity)
        
        let waitTextLabel = UILabel.init(frame: CGRect(x:0,y:0,width:100,height:20))
        waitTextLabel.center = CGPoint(x:(activityView.frame.width)/2,y:(activityView.frame.height)/2 + 15)
        waitTextLabel.text = "加载中..."
        waitTextLabel.font = UIFont.systemFont(ofSize: 14)
        waitTextLabel.textColor = UIColor.darkGray
        waitTextLabel.textAlignment = .center
        activityView.addSubview(waitTextLabel)
        
        return activityView
    }
}


