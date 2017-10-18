//
//  UIImageView+FKKingfisher.swift
//  FlycoSmart
//
//  Created by hss on 2017/9/6.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//
import UIKit
import Kingfisher

extension UIImageView {
    
    func fk_setImage(imageUrl: String, placeholder: String) {
        let url = URL(string:imageUrl)
        self.kf.setImage(with: url, placeholder:UIImage(named:placeholder) , options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
