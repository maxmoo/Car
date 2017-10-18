//
//  Macro.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/1.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import SwiftyBeaver

public func SCREEN_HEIGHT () -> CGFloat {
    return UIScreen.main.bounds.height
}

public func SCREEN_WIDTH () -> CGFloat {
    return UIScreen.main.bounds.width
}

//状态栏高度
public func StatusHeight () -> CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

//状态栏+导航栏
public func TotalNavHeight () -> CGFloat {
    return 44 + StatusHeight()
}

