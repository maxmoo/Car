//
//  B.swift
//  FlycoSmart
//
//  Created by hss on 2017/10/12.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import Foundation

class BView: UIView {
    var startPointArray:[String]
    var endPointArray:[String]
    
    init(frame: CGRect,startP:[String],endP:[String]) {
        self.startPointArray = startP
        self.endPointArray = endP
        super.init(frame: frame)
//        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let w = (SCREEN_WIDTH()-190)/2
        
        for i in 0..<startPointArray.count {
            var startPoint : CGPoint = CGPointFromString(startPointArray[i])
            startPoint.x += w
            var endPoint : CGPoint = CGPointFromString(endPointArray[i])
            endPoint.x += w
            /// 贝塞尔曲线
            let bezierPath : UIBezierPath = UIBezierPath()
            bezierPath.move(to: startPoint)
            bezierPath.addLine(to: endPoint)
            UIColor.red.setStroke()
            bezierPath.lineWidth = 2
            bezierPath.stroke()
        }
    }
}

