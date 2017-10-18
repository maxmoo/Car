//
//  FKRequestError.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/16.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

struct FKError {
    
    var code: Int
    var url: String
    var describ: String
    
    static func infoError(_ error: Error) -> FKError {
        
        var errorUrl: String?
        var errorDiscrib: String?
        
        let localError = error as NSError
        let errorCode = localError.code
        let errorUserInfo = localError.userInfo
        
        if let u = errorUserInfo["NSErrorFailingURLStringKey"] {
            errorUrl = u as? String
        }else{
            errorUrl = "解析出错"
        }
        
        if let d = errorUserInfo["NSLocalizedDescription"] {
            errorDiscrib = d as? String
        }else{
            errorDiscrib = "解析出错"
        }
        
        let customError = FKError(code: errorCode, url:errorUrl!, describ: errorDiscrib!)
        
        return customError
    }
}

