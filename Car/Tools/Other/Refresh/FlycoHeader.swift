//
//  FlycoHeader.swift
//  SwiftPullToRefresh
//
//  Created by hss on 2017/10/12.
//  Copyright © 2017年 Leo Zhou. All rights reserved.
//

import Foundation

final class FlycoHeader: RefreshView {
    
    private var flycoItem: FlycoItem?
    
    init(height: CGFloat, scView: UIScrollView,action: @escaping () -> Void) {
        super.init(height: height, action: action)
        flycoItem = FlycoItem.init(scView: scView)
        addSubview((flycoItem?.animationView)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("SwiftPullToRefresh: init(coder:) has not been implemented")
    }
    
    override func didUpdateState(_ isRefreshing: Bool) {
        flycoItem?.didUpdateState(isRefreshing)
    }
    
    override func didUpdateProgress(_ progress: CGFloat) {
        self.flycoItem?.animationView.alpha = 1
        flycoItem?.didUpdateProgress(progress)
        
        if progress <= 1 && progress >= 0 {
            flycoItem?.animationView.transform = CGAffineTransform.init(scaleX: progress*0.8, y: progress*0.8)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        //开始动画

    }
    
    override func endRefreshing(completion: (() -> Void)?) {
//        self.flycoItem.animationView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        //结束动画
        UIView.animate(withDuration: 0.3, animations: {
            self.flycoItem?.animationView.alpha = 0
        }, completion: { _ in
            completion?()
        })
        super.endRefreshing()
    }
}
