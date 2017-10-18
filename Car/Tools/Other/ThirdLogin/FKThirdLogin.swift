//
//  FKThirdLogin.swift
//  FlycoSmart
//
//  Created by hss on 2017/9/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import SwiftyJSON

enum FKLoginType: String {
    case QQ = "qq"
    case WeChat = "wechat"
    case Weibo = "weibo"
    case Flyco = "flyco"
}

extension FKLoginType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .QQ:
            return "qq"
        case .WeChat:
            return "wechat"
        case .Weibo:
            return "wb"
        case .Flyco:
            return "flyco"
        }
    }
}

enum FKThirdLoginError: String {
    case none
    case networkBreak
    case accessTokenNil
    case loginFailed
    case loginCanceled
    case getUserInfoFailed
    case appNotInstalled
    case other
}


protocol FKThirdLoginDelegate {
    
    //登录过程中可能遇到的错误回调和最终的数据回调
    func loginData(type: FKLoginType, errorType: FKThirdLoginError, data: ThirdUserInfo?)
    //已确认开始登录
    func loginStart(type: FKLoginType)
    //已确认第三方登录且获取第三方用户信息结束
    func loginFinish(type: FKLoginType)
}


class FKThirdLogin: NSObject{
    
    var tencentOAuth: TencentOAuth?
    var delegate: FKThirdLoginDelegate?
    
    static let share = FKThirdLogin()
    
    //第三方登录的入口函数
    /**
    使用时需要调用login函数，实现协议FKThirdLoginDelegate和代理方法
     */
    func login(type: FKLoginType, delegate: FKThirdLoginDelegate) {
        
        self.delegate = delegate
        
        switch type {
        case .QQ:
            FKThirdLogin.share.loginQQ()
        case .WeChat:
            FKThirdLogin.share.loginWeChat()
        case .Weibo:
            FKThirdLogin.share.loginWeibo()
        default:
            break
        }
    }
    
    private func loginQQ() {
        tencentOAuth = TencentOAuth.init(appId: FKAccount.QQ.key, andDelegate: self)
        let auth = ["get_user_info","get_simple_userinfo","add_t"]
        tencentOAuth?.authorize(auth, inSafari: false)
    }
    
    private func loginWeChat() {
        let req = SendAuthReq.init()
        req.scope = "snsapi_userinfo"
        req.state = "WX_REQUEST_STATE"
        
        if WXApi.isWXAppSupport(){
            WXApi.send(req)
        }else{
 
        }
    }
    
    private func loginWeibo() {
        let wbRequest: WBAuthorizeRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        wbRequest.redirectURI = FKAccount.Weibo.redirectURI
        wbRequest.scope = "all"
        WeiboSDK.send(wbRequest)
    }
    
    func thirdOpthions(app:UIApplication,url:URL,launchOptions: [UIApplicationOpenURLOptionsKey : Any]?) -> Bool{
        return TencentOAuth.handleOpen(url) ||
        WeiboSDK.handleOpen(url, delegate: self) ||
        WXApi.handleOpen(url, delegate: self)
    }
 
    func thirdHandle(app: UIApplication,url: URL) -> Bool {
        return TencentOAuth.handleOpen(url) ||
            WeiboSDK.handleOpen(url, delegate: self) ||
            WXApi.handleOpen(url, delegate: self)
    }
}


//腾讯代理
extension FKThirdLogin: TencentSessionDelegate {
    
    func tencentDidLogin() {
        if (tencentOAuth?.accessToken.isEmpty)! {
            delegate?.loginData(type: .QQ, errorType: .accessTokenNil, data: nil)
        }else{
            delegate?.loginStart(type: .QQ)
            tencentOAuth?.getUserInfo()
        }
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        if cancelled {
            delegate?.loginData(type: .QQ, errorType: .loginCanceled, data: nil)
        }else{
            delegate?.loginData(type: .QQ, errorType: .loginFailed, data: nil)
        }
    }
    
    func tencentDidNotNetWork() {
        delegate?.loginData(type: .QQ, errorType: .networkBreak, data: nil)
    }
    
    func getUserInfoResponse(_ response: APIResponse!) {
        if response.jsonResponse.isEmpty {
            delegate?.loginData(type: .QQ, errorType: .loginFailed, data: nil)
            return
        }else{
            let dic: NSDictionary = response.jsonResponse! as NSDictionary
            let info = ThirdUserInfo.init(id: (tencentOAuth?.openId)!, name: dic.object(forKey: "nickname") as! String, imageUrl: dic.object(forKey: "figureurl_qq_2") as! String, token: (tencentOAuth?.accessToken)!)
            delegate?.loginData(type: .QQ, errorType: .none, data: info)
            delegate?.loginFinish(type: .QQ)
        }
    }
}

//微博代理
extension FKThirdLogin: WeiboSDKDelegate,WBHttpRequestDelegate {
    
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        delegate?.loginStart(type: .Weibo)
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if response.isKind(of: WBAuthorizeResponse.self) {
            delegate?.loginStart(type: .Weibo)
            let resp = response as! WBAuthorizeResponse
            getWeiboUserInfo(uid: resp.userID, token: resp.accessToken)
        }
    }
    
    func getWeiboUserInfo(uid: String, token: String) {
        if uid.isEmpty || token.isEmpty {
            delegate?.loginData(type: .Weibo, errorType: .accessTokenNil, data: nil)
            return
        }
        
        Request.wbUserInfo(uid: uid, token: token, key: FKAccount.Weibo.key, success: { (result) in
            let info = ThirdUserInfo.initWBModel(data: result, token: token)
            self.delegate?.loginData(type:.Weibo, errorType:.none, data: info)
            self.delegate?.loginFinish(type: .Weibo)
        }) { (error) in
            logError(error)
            self.delegate?.loginData(type:.Weibo, errorType:.other ,data:nil)
        }
        
    }
}

//微信代理
extension FKThirdLogin: WXApiDelegate {
    
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        delegate?.loginStart(type: .WeChat)
        getFirstCode(resp: resp)
    }
    
    //微信custom method
    func getFirstCode(resp: BaseResp) {
        if resp.isKind(of: SendMessageToWXReq.self) {
            return
        }
        
        if resp.isKind(of: SendAuthResp.self) {
            let response = resp as! SendAuthResp
                        
            switch response.errCode {
            case -4:
                delegate?.loginData(type: .WeChat, errorType:.loginFailed, data:nil)
            case -2:
                delegate?.loginData(type: .WeChat, errorType:.loginCanceled, data:nil)
            case 0:
                getAccessToken(code: response.code)
            default:
                delegate?.loginData(type: .WeChat, errorType:.other ,data:nil)
            }
        }
    }
    
    func getAccessToken(code: String) {
        
        if code.isEmpty {
            delegate?.loginData(type: .WeChat, errorType: .accessTokenNil, data: nil)
        }
        
        Request.wxFirstAccessToken(key: FKAccount.WeChat.key, secret: FKAccount.WeChat.secrect, code: code, success: { (result) in
            self.getWXUserInfo(token: result["access_token"].string!, unionid: result["unionid"].string!)
        }) { (error) in
            logError(error)
            self.delegate?.loginData(type: .WeChat, errorType:.other ,data:nil)
        }
        
    }
    
    func getWXUserInfo(token: String,unionid: String) {
        Request.wxUserInfo(tokenID: token, openID: unionid, success: { (result) in
            let data = ThirdUserInfo.initWXModel(data: result, token: token)
            self.delegate?.loginFinish(type: .WeChat)
            self.delegate?.loginData(type: .WeChat, errorType: .none, data: data)
        }) { (error) in
            logError(error)
            self.delegate?.loginFinish(type: .WeChat)
            self.delegate?.loginData(type: .WeChat, errorType:.other ,data:nil)
        }
    }
    
}


struct ThirdUserInfo {
    var id: String
    var name: String
    var imageUrl: String
    var token: String
    
    static func initWXModel(data:JSON, token: String) -> ThirdUserInfo{
        return ThirdUserInfo.init(id: data["unionid"].string!, name: data["nickname"].string!, imageUrl: data["headimgurl"].string!, token: token)
    }
    
    
    static func initWBModel(data:JSON, token: String) -> ThirdUserInfo{
        return ThirdUserInfo.init(id: data["idstr"].string!, name: data["screen_name"].string!, imageUrl: data["avatar_hd"].string!, token: token)
    }
}


