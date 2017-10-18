//
//  FlycoItem.swift
//  SwiftPullToRefresh
//
//  Created by hss on 2017/10/12.
//  Copyright © 2017年 Leo Zhou. All rights reserved.
//

import Foundation

let startPointKey = "startPoints"
let endPointKey = "endPoints"

final class FlycoItem {
    
    var animationView: UIView!
    var scrollView: UIScrollView!
    
    init(scView: UIScrollView) {
        scrollView = scView
        animationView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: scView.frame.size.width, height: 60))
        animationView.backgroundColor = UIColor.clear
//        animationView.alpha = 0
        animationView.addSubview(indicator)
        indicator.startAnimating()
        indicator.center = CGPoint.init(x: scView.frame.size.width/2, y: 30)
    }
    
    let indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)

    func addData() {
        let str = Bundle.main.path(forResource: "Flyco", ofType: "plist")
        let rootDictionary : NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: str!)!
        
        let startPoints : [String] = rootDictionary.object(forKey: startPointKey) as! [String]
        let endPoints : [String] = rootDictionary.object(forKey: endPointKey) as! [String]
        
        let w = (SCREEN_WIDTH()-190)/2
        
        let bezierPath : UIBezierPath = UIBezierPath()

        for i in 0..<startPoints.count {
            var startPoint : CGPoint = CGPointFromString(startPoints[i])
            startPoint.x += w
            var endPoint : CGPoint = CGPointFromString(endPoints[i])
            endPoint.x += w
            /// 贝塞尔曲线
            bezierPath.move(to: startPoint)
            bezierPath.addLine(to: endPoint)
        }
        
        UIColor.red.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        let shapLayer = CAShapeLayer()
        shapLayer.path = bezierPath.cgPath
        shapLayer.bounds = animationView.frame
        shapLayer.fillColor = UIColor.yellow.cgColor
        
        animationView.layer.mask = shapLayer
    }
    
    func didUpdateState(_ isRefreshing: Bool) {

    }
    
    func didUpdateProgress(_ progress: CGFloat, isFooter: Bool = false) {
//       print("-------\(progress)")
        animationView.center = CGPoint.init(x: scrollView.frame.size.width/2, y: 60 - 30*progress)
    }
}
