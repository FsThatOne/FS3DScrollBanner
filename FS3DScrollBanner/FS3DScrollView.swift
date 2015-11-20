//
//  FS3DScrollView.swift
//  FS3DScrollBanner
//
//  Created by FS小一 on 15/7/6.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

import UIKit

let mainScreenH = UIScreen.mainScreen().bounds.size.height
let mainScreenW = UIScreen.mainScreen().bounds.size.width

protocol clickImgDelegate{
    func clickImg(index: NSInteger)
}

class FS3DScrollView: UIView {

    var currentIndex: Int? = 0
    
    var imageView: UIImageView?
    
    var imageArr: [String]?
    
    var delegate: clickImgDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show3DView(imgArr: [String]){
        imageArr = imgArr
        //定义图片控件
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: mainScreenW, height: 180))
        imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        imageView!.image = UIImage(named: imageArr![0])//默认图片
        imageView!.userInteractionEnabled = true
        userInteractionEnabled = true
        addSubview(imageView!)
        imageView!.tag = 0
        let doubleTap = UITapGestureRecognizer(target: self, action: "doDoubleTap:")
        //默认点击第一张
        imageView!.addGestureRecognizer(doubleTap)

        
        //添加手势
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self ,action: "leftSwipe:")
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        
        addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self ,action: "rightSwipe:")
        rightSwipeGesture.direction=UISwipeGestureRecognizerDirection.Right
        addGestureRecognizer(rightSwipeGesture)

    }
    
    
    //向左滑动浏览下一张图片
    func leftSwipe(gesture: UISwipeGestureRecognizer){
        self.transitionAnimation(true)
    }
    
    //向右滑动浏览上一张图片
    func rightSwipe(gesture: UISwipeGestureRecognizer){
        self.transitionAnimation(false)
    }
    
    // -  转场动画
    func transitionAnimation(isNext: Bool){
    //1.创建转场动画对象
        let transition = CATransition()
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
        transition.type = "cube"
    
    //设置子类型
        if (isNext) {
            transition.subtype=kCATransitionFromRight;
        }else{
            transition.subtype=kCATransitionFromLeft;
        }
    //设置动画时常
        transition.duration = 1.0
    
    //3.设置转场后的新视图添加转场动画
        imageView!.image = getImage(isNext)
        imageView!.layer.addAnimation(transition, forKey: "KCTransitionAnimation")
    }
    
    //取得当前图片
    func getImage(isNext: Bool) -> UIImage {
        if (isNext) {
            currentIndex = (currentIndex! + 1) % imageArr!.count
        }else{
            currentIndex = (currentIndex! - 1 + imageArr!.count) % (Int)(imageArr!.count)
        }
        let imageName: String = imageArr![currentIndex!]
    
    
        imageView!.tag = currentIndex!
        
        let doubleTap = UITapGestureRecognizer(target:self ,action: "doDoubleTap:")
    
        imageView!.addGestureRecognizer(doubleTap)
    
    
        return UIImage(named: imageName)!
    }
    
    func doDoubleTap(gesture: UITapGestureRecognizer)
    {
        delegate?.clickImg((gesture.view?.tag)!)
    }
}
