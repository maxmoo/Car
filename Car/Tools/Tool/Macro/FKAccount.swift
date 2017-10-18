//
//  FKAccount.swift
//  FlycoSmart
//
//  Created by hss on 2017/9/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

/**
 *存放第三方key信息的文件
 */
import UIKit

struct FKAccount {
    
    //QQ
    struct QQ {
        static let key = "1104692486"
        static let secrect = "hYnbvtJh9CmpYZ44"
    }
    
    //微信
    struct WeChat {
        static let key = "wx886566806aba6f3c"
        static let secrect = "f4e253c7a554d681612ef0808a7aa277"
    }
    
    //微博
    struct Weibo {
        static let key = "1680146197"
        static let secrect = "3bbcd02b685b4fa39afb3549c42d32ef"
        static let redirectURI = "https://api.weibo.com/oauth2/default.html"
    }
    
    //友盟
    struct UM {
        static let key = "5720069267e58e1e7a005152"
    }
    
    //京东？？？
    struct JD {
        static let key = "16AC58111113B0EF3F5FE3F96B483652"
        static let secrect = "c4cf07fc49a04143a8313fbb6067cbfa"
    }
}
