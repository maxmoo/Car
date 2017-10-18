//
//  FKRequestUser.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/17.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//请求的基类request
class Request{
    

}

extension Request {
    /*
     *获取服务网点的省份信息
     */
    @discardableResult
    static func
    province(success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
        let params: [String:Any] = ["api_key" : "1439860175",
                                        "api_name" : "APP",
                                        "api_token" : "a84d0a6e3937c5b532592b1eb4f8f6b7"]
        let request = API.start(url: NOBaseURL.province,
                                params: params,
                                method: .GET,
                                timeout: 10,
                                success: {success($0)},failed: {failed($0)})
        return request
    }
    /*
     *获取服务网点的省份内市级信息
     */
    @discardableResult
    static func
    provinceSevice(code:String, success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let params: [String:Any] = ["api_token" : "a84d0a6e3937c5b532592b1eb4f8f6b7",
                                        "api_name" : "APP",
                                        "service_code" : "\(code)",
                                        "api_key" : "1439860175"]
            let request = API.start(url: NOBaseURL.provinceService,
                                    params: params,
                                    method: .GET,
                                    timeout: 10,
                                    success: {success($0)},failed: {failed($0)})
            return request
    }
    //获取城市列表
    @discardableResult
    static func
    city(tokenID: String, success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            
            let url = FKRequestConfig.baseURL() + FKURL.cityList + tokenID
            
            let request = API.start(url: url,
                                    params: ["":""],
                                    method: .GET,
                                    timeout: 10,
                                    success: {success($0)},failed: {failed($0)})
            return request
    }
    
    //微信token
    @discardableResult
    static func
    wxFirstAccessToken(key: String,secret: String, code: String, success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void) -> DataRequest{
        let url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(key)&secret=\(secret)&code=\(code)&grant_type=authorization_code"
        let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
        
        return request
    }
    //获取微信个人信息
    @discardableResult
    static func
    wxUserInfo(tokenID: String,openID: String,
               success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
        let url = "https://api.weixin.qq.com/sns/userinfo?access_token=\(tokenID)&openid=\(openID)"
        let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
        
        return request
    }
    //获取微博用户信息
    @discardableResult
    static func
    wbUserInfo(uid: String,token: String, key: String,
                   success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = "https://api.weibo.com/2/users/show.json?uid=\(uid)&access_token=\(token)&source=\(key)"
            let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            
            return request
    }
    //获取用户信息
    @discardableResult
    static func
    getUserInfo(token: String,success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.userInfo + token
            let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //第三方登录后获取flyco账号信息
    @discardableResult
    static func
    getFlycoUserInfo(flycoKey: String,success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.flycoUserInfo + flycoKey
            let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }

    //登出
    @discardableResult
    static func
    logOut(token: String,success: @escaping (JSON) -> Void, failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.logout
            let params = ["TOKENID":token]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    
    //更新用户信息
    @discardableResult
    static func
    updateUserInfo(token: String,params: [String:Any],
                       success: @escaping (JSON) -> Void,
                       failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.updateAccountInfo + "/" + token
            let request = API.start(url: url,params: params,method: .PUT,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //用户未读信息列表
    @discardableResult
    static func
    userMessage(token: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.userMessage
            let params = ["tokenId":token]
            let request = API.start(url: url,params: params,method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //将信息标记为已读
    @discardableResult
    static func
    readMessage(token: String,messageID: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.readMessage
            let params = ["TOKENID":token,"MESSAGEID":messageID]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //意见反馈
    @discardableResult
    static func
    feedBack(token: String,advice: String, mail: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.feedBack
            let params = ["TOKENID":token,"opinionContent":advice ,"contactMethod":mail]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    
    //绑定相关
    //第三方登录解绑flyco
    @discardableResult
    static func
    thirdDeBindFlyco(token: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.flycoDeBindToThird + token
            let params = ["":""]
            let request = API.start(url: url,params: params,method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //第三方登录绑定flyco
    @discardableResult
    static func
    thirdBindFlyco(token: String,type: String, userName: String,password: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.flycoBindToThird
            let params = ["TOKENID":token,"USERNAME":userName ,"PASSWORD":password,"LOGINTYPE":type]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //登录flyco需要绑定第三方
    @discardableResult
    static func
    flycoBindThird(tokenID: String,UID: String, type: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.thirdBindToFlyco
            let params = ["TOKENID":tokenID,"UID":UID ,"LOGINTYPE":type]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    
    //登录flyco解绑第三方
    @discardableResult
    static func
    flycoDeBindThird(token: String,type: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.thirdDeBindToFlyco + token
            let params = ["unbindType":type]
            let request = API.start(url: url,params: params,method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    //检查用户是否注册过
    @discardableResult
    static func
    checkUserName(name: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.checkUserName
            let params = ["userName":name]
            let request = API.start(url: url,params: params,method: .POST,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
}
