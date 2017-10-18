//
//  FKTabBarViewController.swift
//  FlycoSmart
//
//  Created by hss on 2017/7/31.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit
import TimedSilver

class FKTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewController()
    }
    
    func setupViewController() {
        
        let titleArray: [String] = ["我的车行", "配件配送", "个人中心"]
        
        let normalImagesArray = [
            UIImage(named:"tabbar_discover"),
            UIImage(named:"tabbar_mainframe"),
            UIImage(named:"tabbar_me"),
            ]
        
        let selectedImagesArray = [
            UIImage(named:"tabbar_discoverHL"),
            UIImage(named:"tabbar_mainframeHL"),
            UIImage(named:"tabbar_meHL"),
            ]
        
        let viewControllerArray = [
            storyboardVC(sbName: "Mycar", sbIdentifier: "MyCarViewController") as! MyCarViewController,
            storyboardVC(sbName: "Distribution", sbIdentifier: "DistributionController") as! DistributionController,
            storyboardVC(sbName: "User", sbIdentifier: "UserCenterController") as! UserCenterController
        ]
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem!.title = titleArray[index]
            controller.tabBarItem!.image = normalImagesArray[index]?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.selectedImage = selectedImagesArray[index]?.withRenderingMode(.alwaysOriginal)
//            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: UIControlState())
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: RGB(R: 31, G: 185, B: 34, A: 1)], for: .selected)
            let navigationController = FKBaseNavigantionController(rootViewController: controller)
            navigationVCArray.add(navigationController)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
    }
}
