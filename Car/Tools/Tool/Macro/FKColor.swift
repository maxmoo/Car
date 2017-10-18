//
//  FKColor.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/9.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

func fkMainColor() -> UIColor {
    return RGB(R: 2, G: 22, B: 47, A: 1)
}

func fkBlueColor() -> UIColor {
    return RGB(R: 23, G: 137, B: 235, A: 1)
}

func carNaviColor() -> UIColor {
    return RGB(R: 54, G: 54, B: 54, A: 1)
}

func fkNaviColor(alpha: Float) -> UIColor {
    return RGB(R: 16, G: 69, B: 141, A: CGFloat(alpha))
}

func fkTextColor() -> UIColor {
    return RGB(R: 15, G: 98, B: 193, A: 1)
}

func RGB(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat) -> UIColor {
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}
