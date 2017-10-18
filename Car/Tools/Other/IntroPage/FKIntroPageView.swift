//
//  FKIntroPageView.swift
//  FlycoSmart
//
//  Created by hss on 2017/8/10.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

/*
 //        let fkPage = FKIntroPageView.init(frame: UIScreen.main.bounds)
 //        fkPage.createScrollView(["welcome1","welcome2","welcome3"])
 //        fkPage.show()
 */
import UIKit

class FKIntroPageView: UIView {
    
    var mainScorllView: UIScrollView?
    var imageArray: [String] = []
    let pageControlWidth = 10//pageControl的宽度
    let pageGap = 5//pageControl之间的间隙
    var pageControlView: UIView?
    
    func createScrollView(_ images: [String]) {
        imageArray = images
        createSubviews()
    }
    
    func createSubviews() {
        
        let singleWidth =  CGFloat(self.bounds.width)
        let singleHeight = CGFloat(self.bounds.height)
        let count = imageArray.count
        let allWidth = CGFloat(count) * singleWidth
        
        mainScorllView = UIScrollView()
        mainScorllView?.frame = self.bounds
        mainScorllView?.contentSize = CGSize(width:allWidth,height:singleHeight)
        mainScorllView?.isPagingEnabled = true
        mainScorllView?.backgroundColor = UIColor.lightGray
        mainScorllView?.delegate = self
        mainScorllView?.bounces = false
        mainScorllView?.showsHorizontalScrollIndicator = false
        
        for (index, imageName) in imageArray.enumerated() {
            let imageView = UIImageView.init(frame: CGRect(x:CGFloat(index) * singleWidth,y:0,width:singleWidth,height:singleHeight))
            imageView.image = UIImage.init(named: imageName)
            
            if index == (count - 1) {
                let hideButton = UIButton()
                hideButton.frame = CGRect(x:0,y:0,width:100,height:40)
                hideButton.backgroundColor = UIColor.blue
                hideButton.center = CGPoint(x:singleWidth/2,y:singleHeight - 200)
                hideButton.setTitle("开始体验", for: UIControlState.normal)
                hideButton.addTarget(self, action: #selector(hide), for: UIControlEvents.touchUpInside)
                imageView.isUserInteractionEnabled = true
                imageView.addSubview(hideButton)
            }
            
            mainScorllView?.addSubview(imageView)
        }
        
        self.addSubview(mainScorllView!)
        
        pageControlView = UIView.init(frame: CGRect(x:0,y:Int(singleHeight - 80),width:(count * pageControlWidth + (count - 1) * pageGap),height:pageControlWidth))
//        pageControlView?.backgroundColor = UIColor.green
        pageControlView?.center = CGPoint(x:self.bounds.width/2,y:singleHeight - 80)
        for (index,_) in imageArray.enumerated() {
            let pageImageView = UIImageView.init(frame: CGRect(x:(index * (pageControlWidth + pageGap)),y:0,width:pageControlWidth,height:pageControlWidth))
            pageImageView.backgroundColor = UIColor.gray
            pageImageView.layer.cornerRadius = CGFloat(pageControlWidth/2)
            pageImageView.layer.masksToBounds = true
            pageImageView.tag = index + 1000
            
            pageControlView?.addSubview(pageImageView)
        }
        
        self.addSubview(pageControlView!)
        pageIndexChange(0)
    }
    
    
    func pageIndexChange(_ index: Int) {
        let pageArray = pageControlView?.subviews
        
        for imageView in pageArray! {
            if Int(imageView.tag - 1000) == index {
                imageView.backgroundColor = UIColor.white
            }else{
                imageView.backgroundColor = UIColor.gray
            }
        }
    }
    
    func show() {
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    @objc func hide() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x:-SCREEN_WIDTH(),y:0,width:SCREEN_WIDTH(),height:SCREEN_HEIGHT())
        }) { (flag) in
            self.removeFromSuperview()
            UIApplication.shared.isStatusBarHidden = false
        }
        
    }
}


extension FKIntroPageView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        var index = scrollView.contentOffset.x / UIScreen.main.bounds.width
        let xSet = scrollView.contentOffset.x.truncatingRemainder(dividingBy: UIScreen.main.bounds.width)
        
        if xSet > UIScreen.main.bounds.width/2 {
            index += 1
        }
        
        pageIndexChange(Int(index))
    }
}
