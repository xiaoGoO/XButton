//
//  ViewController.swift
//  MySwift
//
//  Created by 关伟洪 on 2017/6/5.
//  Copyright © 2017年 关伟洪. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var xBtn: XButton!
    
    @IBOutlet weak var imgTopTF: UITextField!
    @IBOutlet weak var imgLeft: UITextField!
    @IBOutlet weak var imgBottom: UITextField!
    @IBOutlet weak var imgRight: UITextField!
    
    @IBOutlet weak var titleTop: UITextField!
    @IBOutlet weak var titleLeft: UITextField!
    @IBOutlet weak var titleBottom: UITextField!
    @IBOutlet weak var titleRight: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xBtn.setOnClick { (btn:UIButton) in
            print("xxxxxxxx");
        };
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onImageArr(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            xBtn.type = .Top
        case 2:
            xBtn.type = .Left
        case 3:
            xBtn.type = .Right
        case 4:
            xBtn.type = .Bottom
        case 11:
            xBtn.contentVerticalAlignment = UIControlContentVerticalAlignment.top;
        case 12:
            xBtn.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom;
        case 13:
            xBtn.contentVerticalAlignment = UIControlContentVerticalAlignment.center;
        case 14:
            xBtn.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        case 21:
            xBtn.contentHorizontalAlignment = .left;
        case 22:
            xBtn.contentHorizontalAlignment = .right;
        case 23:
            xBtn.contentHorizontalAlignment = .center;
        case 24:
            xBtn.contentHorizontalAlignment = .fill;
        default:
            xBtn.type = .Left
        }
        xBtn.setNeedsLayout();
        xBtn.setNeedsDisplay();
    }

    @IBAction func onImageEdgeInsets(_ sender: Any) {
        var top:CGFloat = 0;
        if let doubleValue = Double(imgTopTF.text!){
            top = CGFloat(doubleValue);
        }
        var left:CGFloat = 0;
        if let doubleValue = Double(imgLeft.text!){
            left = CGFloat(doubleValue);
        }
        var right:CGFloat = 0;
        if let doubleValue = Double(imgRight.text!){
            right = CGFloat(doubleValue);
        }
        var bottom:CGFloat = 0;
        if let doubleValue = Double(imgBottom.text!){
            bottom = CGFloat(doubleValue);
        }
        
        xBtn.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right);
        xBtn.setNeedsLayout();
        xBtn.setNeedsDisplay();
    }

    @IBAction func onTitleEdgeInsets(_ sender: Any) {
        var top:CGFloat = 0;
        if let doubleValue = Double(titleTop.text!){
            top = CGFloat(doubleValue);
        }
        var left:CGFloat = 0;
        if let doubleValue = Double(titleLeft.text!){
            left = CGFloat(doubleValue);
        }
        var right:CGFloat = 0;
        if let doubleValue = Double(titleRight.text!){
            right = CGFloat(doubleValue);
        }
        var bottom:CGFloat = 0;
        if let doubleValue = Double(titleBottom.text!){
            bottom = CGFloat(doubleValue);
        }
        xBtn.setNeedsLayout();
        xBtn.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right);
        xBtn.setNeedsDisplay();
    }
    
    @IBOutlet weak var onVer: UIButton!
    
    
}

