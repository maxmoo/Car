//
//  FKBaseViewController.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class FKBaseViewController: UIViewController {
    
    //导航栏变色的默认高度
    let maxScrollHeight: CGFloat = 60.0
    
    var navigationBackgroundImageView: UIImageView?
    var defaultView: UIView?
    var activityView: UIView?
    var emptyView: UIView?

    //设置独立的导航栏颜色时需要重载这个属性
    var navigationBackgroundImage: UIImage? {
        get {
            return UIImage(named:"navibar_bg")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.edgesForExtendedLayout = .bottom
//        self.contentInsetAdjustmentBehavior = .never
//        extendedLayoutIncludesOpaqueBars = false
//        self.navigationController?.navigationBar.isTranslucent = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navBarBackgroundColor = carNaviColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        customNavigationBackButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationbarBackColor()
        customNavigationBackButton()
    }
    
    //设置导航栏背景色
    func customNavigationbarBackColor() {
        self.navigationController?.navigationBar.barStyle = .black
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    //设置导航栏返回按钮
    func customNavigationBackButton() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 重要方法，用来调整自定义返回view距离左边的距离
        if (navigationController?.viewControllers.count)! > 1 {
            let backButton = UIButton.init(type: .custom)
            backButton.frame = fk_Rect(0, 0, 20, 18)
            backButton.setBackgroundImage(UIImage(named:"nav_back"), for: .normal)
            backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            let backItem = UIBarButtonItem.init(customView: backButton)
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            barButtonItem.width = -5
            navigationItem.leftBarButtonItems = [barButtonItem, backItem]
        }
    }
    
    @objc final func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}


extension FKBaseViewController {
    final func navigetionColor(offset:CGFloat) {
        let a = offset / maxScrollHeight
        self.navigationController?.navigationBar.cc_setBackgroundColor(fkNaviColor(alpha: Float(a)))
    }
}

/**
 *使用时addDefaultView()
 *重写defaultViewInfo()来设置custom属性
 */
extension FKBaseViewController{
    
    func refreshAction() {
        hideDefaultView()
        hideEmptyView()
        startActivity()
    }
    
    //可以用重写属性来代替
    func defaultViewInfo() -> Dictionary<String, Any> {
        return [kDefaultMessageKey:"请点击下方按钮重新加载",
                kDefaultBackColorKey:UIColor.clear,
                kDefaultButtonTitle:"重新加载",
                kDefaultTextColor:UIColor.darkGray]
    }
    
    final func initDefaultView() {
        
        defaultView = FKBaseDefaultView().defaultView(addToView: view, info: defaultViewInfo(), complete: {
          self.refreshAction()
        })
        view.addSubview(defaultView!)
    }
    
    final func showDefaultView() {
        hideDefaultView()
        initDefaultView()

        stopActivity()
        hideEmptyView()
    }
    
    final func hideDefaultView() {
        defaultView?.removeFromSuperview()
        defaultView = nil
    }
}

//默认加载提示default loading
extension FKBaseViewController {
    
    final func initActivity() {
        activityView = FKBaseDefaultView().activityView(addToView: view)
        view.addSubview(activityView!)
    }
    
    final func startActivity() {
        if (activityView == nil) {
            initActivity()
        }else{
            view.addSubview(activityView!)
        }
        hideEmptyView()
        hideDefaultView()
    }
    
    final func stopActivity() {
        activityView?.removeFromSuperview()
    }
}

//empty view
extension FKBaseViewController {
    
    //可以重写
    func emptyMessage() -> String {
        return "没有更多数据."
    }
    
    func emptyImageName() -> String {
        return ""
    }
    
    final func initEmptyView() {
        emptyView = FKBaseDefaultView().emptyView(addToView: view, emptyMessage: emptyMessage(), emptyImageName: emptyImageName())
        view.addSubview(emptyView!)
    }
    
    
    final func showEmptyView() {
        if emptyView == nil {
            initEmptyView()
        }else{
            view.addSubview(emptyView!)
        }
        stopActivity()
        hideDefaultView()
    }
    
    final func hideEmptyView() {
        emptyView?.removeFromSuperview()
    }
}
