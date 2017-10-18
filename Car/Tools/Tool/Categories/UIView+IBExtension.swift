//
//  UIView+IBExtension.swift
//  ZLWifi
//
//  Created by Damo on 2017/7/12.
//  Copyright © 2017年 Damo. All rights reserved.
//
import UIKit

 extension UIView {
    
    @IBInspectable var cornerRadius:CGFloat  {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
         
        }
        get {
           return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            self.layer.borderColor = newValue?.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
}

