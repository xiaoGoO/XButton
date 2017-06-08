//
//  UIButton+extsion.swift
//  MySwift
//
//  Created by 关伟洪 on 2017/6/7.
//  Copyright © 2017年 关伟洪. All rights reserved.
//

import UIKit



extension UIButton {
    struct UIButtonKey {
        static var onClickKey = "onClickKey"
    }
    
    /**
     * 添加点击回调
     * 注意：当控件被调用 func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) 方法后，该回调将会被失效
     */
    public func setOnClick(_ onClickBlock:((UIButton) ->Void)?){
        if onClickBlock != nil{
            objc_setAssociatedObject(self, &UIButtonKey.onClickKey, onClickBlock!, .OBJC_ASSOCIATION_COPY_NONATOMIC);
            self.addTarget(action: #selector(UIButton.onClick(_:)), for: UIControlEvents.touchUpInside);
        }
    }
    
    private func addTarget(action: Selector, for controlEvents: UIControlEvents) {
        super.addTarget(self, action: action, for: controlEvents);
    }
    
    /**
     * 添加事件
     * 该方法不可与 setOnClick 重复使用
     *
     */
    open override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        super.addTarget(target, action: action, for: controlEvents);
        //清空回调绑定
        objc_setAssociatedObject(self, &UIButtonKey.onClickKey, nil, .OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    func onClick(_ btn:UIButton){
        guard let onClickBlock:(UIButton) ->Void = objc_getAssociatedObject(self, &UIButtonKey.onClickKey) as? (UIButton) -> Void else {
            return;
        }
        onClickBlock(self);
    }

}
