//
//  CouponViewController.swift
//  Car
//
//  Created by hss on 2017/10/18.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class CouponViewController: FKBaseViewController {

    var couponTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCouponTableView()
//        showEmptyView()
    }
    
    override func emptyMessage() -> String {
        return "您目前没有优惠券，请多留意官网活动哦"
    }
    
    func initCouponTableView() {
        couponTableView = UITableView.init(frame: fk_Rect(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT() - TotalNavHeight() - 44), style: .plain)
        couponTableView.delegate = self
        couponTableView.dataSource = self
        couponTableView.ts_registerCellNib(CouponTableViewCell.self)
        couponTableView.separatorStyle = .none
        view.addSubview(couponTableView)
    }
}

extension CouponViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension CouponViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CouponTableViewCell = tableView.ts_dequeueReusableCell(CouponTableViewCell.self)

        return cell
    }
}
