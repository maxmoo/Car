//
//  AssetsViewController.swift
//  Car
//
//  Created by hss on 2017/10/18.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class AssetsViewController: FKBaseViewController {

    var slideMenu:CKSlideMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资产"
        
        addChildController()
    }
    
    func addChildController() {
        let titles = ["积分","优惠券"]
        var arr:Array<UIViewController> = []
        
        let integralVC = IntegralViewController()
        self.addChildViewController(integralVC)
        arr.append(integralVC)
        
        let couponVC = CouponViewController()
        self.addChildViewController(couponVC)
        arr.append(couponVC)
        
        slideMenu = CKSlideMenu(frame: CGRect(x:0,y:TotalNavHeight(),width:view.frame.width,height:40), titles:titles, childControllers:arr)
        slideMenu?.indicatorStyle = .normal
        slideMenu?.indicatorWidth = 25

        slideMenu?.titleStyle = .transfrom
        slideMenu?.selectedColor = carMainColor()
        slideMenu?.unSelectedColor = UIColor.gray
        slideMenu?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(slideMenu!)
    }
}
