//
//  FKRequestURL.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/16.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

/*
 URL先大致分为两类，用户信息相关一类，设备信息相关一类
 因为有部分URL相同，需要用到对应的URL是再进行添加
 */

struct FKURL {
    //-----------------------Account------------------------------------
    static let register             = "/UserCore/service/user/new"
    static let login                = "/UserCore/service/user/loginIn"
    static let thirdLogin           = "/UserCore/service/thirdpartyuser/loginIn"
    static let logout               = "/UserCore/service/user/loginOut"
    static let verifyPhoneNum       = "/UserCore/service/user/verify"
    static let checkPhoneVerifyCode             = "/UserCore/service/user/check"
    static let checkVerifyCodeNotRegistered     = "/UserCore/service/user/identifycode"
    static let verifyCodeForResetPassword       = "/UserCore/service/user/identifycode"
    static let resetPassword            = "/UserCore/service/user/reset"
    static let sendVerifyCodeDirectly   = "/UserCore/service/user/send"
    static let checkUser                = "/UserCore/service/user/checkUserName"
    static let fetchAccountInfo         = "/UserCore/service/user"
    static let updateAccountInfo        = "/UserCore/service/user"
    static let userInfo                 = "/UserCore/service/user/"
    static let flycoUserInfo            = "/UserCore/service/getuser/"
    static let changeUserName           = "/UserCore/service/user/"
    static let cityList                 = "/UserCore/service/find/allRegions/"
    static let getPicVerifyCode         = "/UserCore/service/user/randomcode"
    static let resetMailPassword        = "/UserCore/service/user/email"
    static let userMessage              = "/UserCore/service/my/messages"//用户未读信息
    static let readMessage              = "/my/readmessages"///my/readmessages
    static let feedBack                 = "/UserCore/service/my/opinion"//意见反馈
    static let thirdBindToFlyco         = "/UserCore/service/flycobindthirdparty"    //将第三方与flyco绑定
    static let thirdDeBindToFlyco       = "/UserCore/service/flycounbindthirduser/"  //将第三方与flyco解绑
    static let flycoBindToThird         = "/UserCore/service/thirduserbindflyco"     //将flyco与第三方绑定
    static let flycoDeBindToThird       = "/UserCore/service/thirduserunbindflyco/"  //将flyco与第三方解绑
    static let checkUserName            = "/UserCore/service/user/checkUserName" //通过用户名检查用户是否注册过
    //-----------------------Device------------------------------------
    static let addDevice            = "/UserCore/service/devices/add"
    static let resetDevice          = "/UserCore/service/devices/resetWifiSuccess"
    static let device               = "/UserCore/service/devices"//delete change devicelist
    static let checkAppUpdate       = "/UserCore/service/find/currentVersion"
    static let FetchProductShowCase = "/UserCore/service/find/addibleproductorList/?tokenId="
    static let SetPowerStatus       = "/Inbound/devices"
    static let qrCode               = "/UserCore/service/devices/checkIfBinded"
}

/*
 *与baseURL不同且切换环境不影响的URL
 *一些H5 URL也放在此结构体
 */
struct NOBaseURL {
    static let province         = "https://mallapp.flyco.com/appapi/index.service.area"
    static let provinceService  = "https://mallapp.flyco.com/appapi/index.service.list"
    static let flycoProtocol    = "https://user01.flyco.net.cn/flyco_resource/protocol/user_protocol.html"
    static let onlineService    = "http://kf3.flyco.net.cn/index/app?companyId=70722519&style=default&mode=app&uid="
}


struct ImageUrl {
    static let test = "http://121.40.104.203:8080"
    static let product = "http://app02.flyco.net.cn"
}
