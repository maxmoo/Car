//
//  FKRequestDevice.swift
//  FKNetDemo
//
//  Created by hss on 2017/8/17.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Request {

    //设备列表信息
    @discardableResult
    static func
    deviceList(token: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.device + "/" + token
            let request = API.start(url: url,params: ["":""],method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
    
    //解析二维码
    @discardableResult
    static func
    qrCode(token: String, code: String,success: @escaping (JSON) -> Void,failed: @escaping (FKError) -> Void)
        -> DataRequest{
            let url = FKRequestConfig.baseURL() + FKURL.qrCode
            let params = ["tokenId":token,
                          "barCode":code]
            let request = API.start(url: url,params: params ,method: .GET,timeout: 10,success: {success($0)},failed: {failed($0)})
            return request
    }
}
