//
//  StoryboardHelper.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit


func storyboardVC(sbName: String, sbIdentifier: String) -> UIViewController? {

    let sb = UIStoryboard(name: sbName, bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: sbIdentifier) 
    
    return vc
}

