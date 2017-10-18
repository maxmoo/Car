//
//  UIImage+FKExtension.swift
//  FlycoSmart
//
//  Created by hss on 2017/9/12.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

extension UIImage {
    
    func fk_headDataString() -> String {
        //    NSData* imgData = UIImageJPEGRepresentation(img,0.1);
        let imageData = UIImageJPEGRepresentation(self,0.1)
        //        base64ImageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        let dataString = imageData?.base64EncodedString(options: .endLineWithLineFeed)
        
        return dataString!
    }
    
}
