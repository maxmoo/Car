//
//  FKBaseNavigantionController.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/7.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class FKBaseNavigantionController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
    }
}


extension FKBaseNavigantionController: UIGestureRecognizerDelegate {
    /*
     *设置自定义的返回按钮和事件后系统自带的滑动返回手势会消失
     *在根导航控制器设置interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
     *实现协议方法gestureRecognizerShouldBegin 控制手势的有效范围可解决问题
     *注意：此方案还可解决在根视图控制器侧滑时APP卡死的问题
     */
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
}
//hidesBottomBarWhenPushed
extension FKBaseNavigantionController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension FKBaseNavigantionController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = FKControllerAnimate()
        animationController.operation = operation
        return animationController
    }
}

