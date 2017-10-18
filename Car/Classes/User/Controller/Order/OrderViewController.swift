//
//  OrderViewController.swift
//  Car
//
//  Created by hss on 2017/10/18.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class OrderViewController: FKBaseViewController {

    var slideMenu:CKSlideMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        
        addChildController()
    }
    
    func addChildController() {
        let titles = ["待付款","待收货","已完成"]
        var arr:Array<UIViewController> = []
        
        let willPayVC = WillPayViewController()
        self.addChildViewController(willPayVC)
        arr.append(willPayVC)
        
        let willReceiveVC = WillReceiveViewController()
        self.addChildViewController(willReceiveVC)
        arr.append(willReceiveVC)
        
        let completeVC = CompleteOrderViewController()
        self.addChildViewController(completeVC)
        arr.append(completeVC)
        
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
