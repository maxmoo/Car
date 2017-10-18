//
//  Date+FKExtention.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/28.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import Foundation

extension Date {
    
    static func stringWithDate(_ date: Date, fms: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // 设置时区
        dateFormatter.dateFormat = fms
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    static func stringWithString(_ str: String, fms: String, bfms: String) -> String {
        let date = Date.dateWithString(str, fms: fms)
        let string = Date.stringWithDate(date, fms: bfms)
        return string
    }
    
    
    static func dateWithString(_ str: String, fms: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // 设置时区
        dateFormatter.dateFormat = fms
        let date = dateFormatter.date(from: str)
        
        return date!
    }
}
