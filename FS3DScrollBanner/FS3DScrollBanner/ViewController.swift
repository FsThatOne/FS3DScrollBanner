//
//  ViewController.swift
//  FS3DScrollBanner
//
//  Created by FS小一 on 15/7/31.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//



import UIKit



class ViewController: UIViewController , clickImgDelegate {

    let imgArr = ["0","1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let test13D = FS3DScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 180))
        test13D.delegate = self
        test13D.show3DView(imgArr)
        view.addSubview(test13D)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickImg(index: NSInteger) {
        print("点了第\(index + 1)张图片")
    }


}

