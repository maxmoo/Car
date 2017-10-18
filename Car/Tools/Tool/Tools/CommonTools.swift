//
//  CommonTools.swift
//  FlycoSmart
//
//  Created by hss on 2017/10/13.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import Foundation

//延迟函数
public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func tableSelectBackView(frame: CGRect) -> UIView {
    let backView = UIView.init(frame: frame)
    backView.backgroundColor = fkNaviColor(alpha: 0.2)
    return backView
}
