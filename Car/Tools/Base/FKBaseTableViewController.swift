//
//  FKBaseTableViewController.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/28.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class FKBaseTableViewController: UITableViewController {

    var activityView: UIView?
    var defaultView: UIView?
    var emptyView: UIView?
    var navigationBackgroundImageView: UIImageView?

    var navigationBackgroundImage: UIImage? {
        get {
            return UIImage(named:"navibar_bg")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 11.0, *) {
//            self.tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            // Fallback on earlier versions
//        }
        self.navBarBackgroundColor = carNaviColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationbarBackColor()
        customNavigationBackButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func customNavigationBackButton() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 重要方法，用来调整自定义返回view距离左边的距离
        if (navigationController?.viewControllers.count)! > 1 {
            let backButton = UIButton.init(type: .custom)
            backButton.frame = fk_Rect(-10, 0, 20, 18)
            backButton.setBackgroundImage(UIImage(named:"nav_back"), for: .normal)
            backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            let backItem = UIBarButtonItem.init(customView: backButton)
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            barButtonItem.width = -5
            navigationItem.leftBarButtonItems = [barButtonItem, backItem]
        }
    }
    
    //设置导航栏背景色
    func customNavigationbarBackColor() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    @objc final func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

//default提示页面
/**
 *使用时addDefaultView()
 *重写defaultViewInfo()来设置custom属性
 */
extension FKBaseTableViewController{
    
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
extension FKBaseTableViewController {
    
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
extension FKBaseTableViewController {
    
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

