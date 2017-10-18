//
//  FKRequestCentral.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/16.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API {
    /**
     *url:网络请求的URL
     *params:请求参数
     *timeout:请求超时时间，默认30s
     *success:请求成功回调，已转为JSON格式
     *failed:请求失败回调，返回FKError
     *return:返回request，可用于取消特定网络请求，可忽略返回参数
     */
    @discardableResult
    static func
    start(url: String,
          params: [String:Any],
          method: RequestMethod,
          timeout: Int = 30,
          success: @escaping (JSON) -> Void,
          failed: @escaping (FKError) -> Void) -> DataRequest {
        
        let requestURL = url
        var requestMethod: HTTPMethod {
            get{
                return HTTPMethod(rawValue:method.rawValue)!
            }
        }

        var pCoding: ParameterEncoding = URLEncoding.default
        switch requestMethod {
        case .put,.post:
            pCoding = JSONEncoding.default
        default:
            pCoding = URLEncoding.default
        }
        
        //1,responseJSON
        //开始状态栏菊花动画
        startStatusNetworkActivity()
        //打印
        print("\n请求连接：\(requestURL)")
        print("方法：\(requestMethod.rawValue)")
        print("参数：\(params)")
        print("超时时间：\(timeout)\n")
        
        let manager = customManager(timeoutInterval: TimeInterval(timeout))
        
        let request = manager.request(requestURL,
                                      method: requestMethod,
                                      parameters: params,
                                      encoding:pCoding,
                                      headers:SessionManager.defaultHTTPHeaders).responseJSON {(returnResult) in
            
            //停止状态栏菊花动画
            stopStatusNetworkActivity()
            
            switch returnResult.result {
            case .success(let value):
                //打印数据过多可能会引起程序卡顿
                DispatchQueue.global().async {
                    logPass(JSON(value))
                }
                success(JSON(value))
            case .failure(let error):
                logError(FKError.infoError(error))
                failed(FKError.infoError(error))
            }
            
        }
    
        return request
    }
}

extension API {
    
    //same tools method
    static func startStatusNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    static func stopStatusNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension API {
    /**
     *manager可以访问HTTPS
     */
    static func customManager(timeoutInterval: TimeInterval) -> Alamofire.SessionManager  {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = timeoutInterval
        let manager = SessionManager(configuration: configuration)
        
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust! )
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
        
        return manager
    }
}

