//
//  AppInfoTools.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/24.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class AppInfoTools {
    
    struct AppInfoKey {
        static let productVersion           = "CFBundleShortVersionString"
        static let testEnvironmentVersion   = "TestEnvironmentShortVersionString"
    }
    
    //测试版本号
    static func appTestVersion() -> String {
        return appInfo(AppInfoKey.testEnvironmentVersion)
    }
    //正式版本号
    static func appProductVersion() -> String{
        return appInfo(AppInfoKey.productVersion)
    }
    
    static func appInfo(_ key: String) -> String {
        return (Bundle.main.infoDictionary?[key] as? String)!
    }
}

public func fk_Rect(_ x:CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x:x,y:y,width:width,height:height)
}

public func fk_Point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
    return CGPoint(x:x,y:y)
}

public func fk_Size(_ width:CGFloat, _ height:CGFloat) -> CGSize {
    return CGSize(width:width,height:height)
}



