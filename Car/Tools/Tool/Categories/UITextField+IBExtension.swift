//
//  UITextField+IBExtension.swift
//  FlycoSmart
//
//  Created by Damo on 2017/8/24.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }    
}
