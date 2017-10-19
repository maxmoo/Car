//
//  IntegralViewController.swift
//  Car
//
//  Created by hss on 2017/10/18.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class IntegralViewController: FKBaseViewController {

    var integralTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showEmptyView()
        initCouponTableView()
    }
    
    override func emptyMessage() -> String {
        return "您目前没有积分，要多努力哦"
    }
    
    func initCouponTableView() {
        integralTableView = UITableView.init(frame: fk_Rect(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT() - TotalNavHeight() - 44), style: .plain)
        integralTableView.delegate = self
        integralTableView.dataSource = self
        integralTableView.ts_registerCellNib(IntegralTableViewCell.self)
        integralTableView.separatorStyle = .none
        view.addSubview(integralTableView)
    }
}

extension IntegralViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension IntegralViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IntegralTableViewCell = tableView.ts_dequeueReusableCell(IntegralTableViewCell.self)
        
        return cell
    }
}
