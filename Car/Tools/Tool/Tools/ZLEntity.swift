//
//  ZLEntity.swift
//  FlycoSmart
//
//  Created by Damo on 2017/8/15.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

enum Validate {
    case email(_ : String)
    case phoneNum(_ : String)
    case varifyCode(_ : String)
    
    var isRight: Bool {
        var predicateStr:String!
        var currObject:String!
        switch self {
        case let .email(str):
            predicateStr = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            currObject = str
        case let .phoneNum(str):
            predicateStr = "1[3|5|7|8|][0-9]{9}"
            currObject = str
        case let .varifyCode(str):
            predicateStr = "^[0-9]*$"
            currObject = str
        }
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
}


public func getPathFromReversedURLAtIndex(url: URL?,index: Int) -> String? {
    guard let _ = url else {
        return nil
    }
    var array = url!.pathComponents
    array = array.reversed()
    
    guard array.count > index else {
        return nil
    }
    
    let str = array[index]
    return str
}

public func isSameWithAllChar(_ str: String) -> Bool{
    let temp = str as NSString
    var result = true
    for i in 1..<str.characters.count {
        autoreleasepool {
            let str1 = temp.substring(with: NSRange(location: i - 1, length: 1))
            let str2 = temp.substring(with: NSRange(location: i, length: 1))

            if str1 != str2 {
                result = false
            }
        }
    }
    
    return result
}


precedencegroup MatchPrecedence {
    associativity: none
    lowerThan: ComparisonPrecedence
}

infix operator =?: MatchPrecedence

extension String {
    static func =?(lhs:inout String, rhs: String?) {
        if let _ = rhs {
            lhs = rhs!
        }
    }
}


