//
//  Log.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/1.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

public func logPass(_ logString: Any,
                    file: String = #file,
                    method: String = #function,
                    line: Int = #line){
    let flag = "✅✅通过✅✅:"
    let com = "\((file as NSString).lastPathComponent).[\(line)].\(method):"
    logAll("\(flag)\(com) \(logString)")
}

public func logError(_ logString: Any,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line){
    let flag = "‼️‼️错误‼️‼️:"
    let com = "\((file as NSString).lastPathComponent).[\(line)].\(method):"
    logAll("\(flag)\(com) \(logString)")
}

public func logWarning(_ logString: Any,
                       file: String = #file,
                       method: String = #function,
                       line: Int = #line){
    let flag = "⚠️⚠️警告⚠️⚠️:"
    let com = "\((file as NSString).lastPathComponent).[\(line)].\(method):"
    logAll("\(flag)\(com) \(logString)")
}

public func logAll(_ logString: Any){
    let time = Date.stringWithDate(Date(), fms: "yyyy-MM-dd HH:mm:ss")
    print("\n[\(time)]\(logString)")
}

public func printLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line) {
    print("\n\((file as NSString).lastPathComponent).[\(line)].\(method):\n \(message)\n")
}
