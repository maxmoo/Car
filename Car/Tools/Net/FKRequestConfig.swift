//
//  FKRequestConfig.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/16.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

/**
 *网络请求的基础配置：环境切换、请求类型、单例、本地存储等
 */

import UIKit

class FKRequestConfig {
    static func baseURL() -> String{
        return FKEnvironment.sharedInstance.type.rawValue
    }
    
    static func imageBaseUrl() -> String {
        var imageUrl = ImageUrl.product
        switch FKEnvironment.sharedInstance.type {
        case .formalEnvironmentHTTP:
            imageUrl = ImageUrl.product
        case .formalEnvironmentHTTPS:
            imageUrl = ImageUrl.product
        case .testEnvironmentHTTP:
            imageUrl = ImageUrl.test
        case .testEnvironmentHTTPS:
            imageUrl = ImageUrl.test
        }
        
        return imageUrl
    }
}

/**
 *请求方式
 */
enum RequestMethod: String {
    case GET    = "GET"
    case PUT    = "PUT"
    case POST   = "POST"
    case DELETE = "DELETE"
}

/**
 *环境
 */
enum EnvironmentType: String {
    case formalEnvironmentHTTP  = "http://app02.flyco.net.cn"   //正式环境http
    case testEnvironmentHTTP    = "http://121.40.104.203:8080"  //测试环境http
    case formalEnvironmentHTTPS = "https://app02.flyco.net.cn"  //正式环境https
    case testEnvironmentHTTPS   = "https://121.40.104.203:443"  //测试环境https
}

/**
 * 配网环境
 */
enum WifiEnvironment: String {
    case wifiEnvironmentLexin   //乐鑫
    case wifiEnvironmentFlyco   //飞科
    case wifiEnvironmentMix     //混合
}


let kEnvironmentKey: String     = "com.flyco.environment"
let kWifiEnvironmentKey: String = "com.flyco.wifiEnvironment"


class FKEnvironment {
    //单例
    static let sharedInstance = FKEnvironment()
    //属性
    //HTTP、HTTPS请求baseURL配置
    var type: EnvironmentType {
        get{
            if UserDefaults.standard.value(forKey: kEnvironmentKey) != nil{
                let localEnvironmentType = EnvironmentType(rawValue:UserDefaults.standard.value(forKey: kEnvironmentKey)! as! String)
                return localEnvironmentType!
            }else{
                return .formalEnvironmentHTTP
            }
        }
        set(newType){
            UserDefaults.standard.setValue(newType.rawValue, forKey: kEnvironmentKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    //wifi配网方案配置
    var wifiEnvironmentType: WifiEnvironment {
        get {
            if UserDefaults.standard.value(forKey: kWifiEnvironmentKey) != nil{
                let localEnvironmentType = WifiEnvironment(rawValue:UserDefaults.standard.value(forKey: kWifiEnvironmentKey)! as! String)
                return localEnvironmentType!
            }else{
                return .wifiEnvironmentFlyco
            }
        }
        set(newType){
            UserDefaults.standard.setValue(newType.rawValue, forKey: kWifiEnvironmentKey)
            UserDefaults.standard.synchronize()
        }
    }
}


