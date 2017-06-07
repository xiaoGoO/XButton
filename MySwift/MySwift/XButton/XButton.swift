//
//  XButton.swift
//  MySwift
//
//  Created by 关伟洪 on 2017/6/6.
//  Copyright © 2017年 关伟洪. All rights reserved.
//

import UIKit

class XButton: UIButton {
    enum XButtonType:Int {
        case Left = 0
        case Top
        case Bottom
        case Right
    }
    
    
    var _type:XButtonType = .Left;
    
    public var type:XButtonType{
        get{
            return _type
        }
        set{
            _type = newValue;
            //刷新UI
            self.setNeedsLayout();
            self.setNeedsDisplay();
        }
    }
    /**
     * 重新 该方法，使之自动刷新UI
     */
    override var contentVerticalAlignment: UIControlContentVerticalAlignment{
        get{
            return super.contentVerticalAlignment;
        }
        set{
            super.contentVerticalAlignment = newValue;
            self.setNeedsLayout();
            self.setNeedsDisplay();
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //获取图片大小以及比例 （用于计算位置）
        var imageWidth = imageView?.image == nil ? 0:imageView!.image!.size.width;
        var imageHeight = imageView?.image == nil ? 0:imageView!.image!.size.height;
        let imageScale = imageWidth / imageHeight;
        
        
        
        //获取 标题宽度
        var titleWidth = self.getTitleRect(titleLabel?.text, titleLabel!.font, CGSize(width: CGFloat.greatestFiniteMagnitude, height: titleLabel!.frame.size.height)).size.width;
        
        //图片受到 偏移值影响后的 图片宽高 以及标题宽高 (只用于设置高度UIView 大小)
        var imageWidthOff = imageWidth;
        var imageHeightOff = imageHeight;
        var titleWidthOff = titleWidth;
        var titleHeightOff:CGFloat = 0;
        
        self.titleLabel?.numberOfLines = isSuperLines ? 0:1;
        
        switch type {
        case .Left,.Right://当图片靠左或者靠右
            //限制 图片大小 不可超出屏幕
            if imageHeight > self.frame.size.height{
                imageHeight = self.frame.size.height;
                imageWidth = imageHeight * imageScale;
            }
            if imageWidth > self.frame.size.width{
                imageWidth = self.frame.size.width;
                imageHeight = imageWidth / imageScale;
            }
            //如果计算的图片高度 > 布局的高度 - 图片上下偏移量
            if imageHeight > self.frame.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom{
                //重新计算图片的新高度 => 布局的高度 - 图片上下偏移量
                imageHeightOff = self.frame.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
                //高度不可 < 0
                imageHeightOff = imageHeightOff >= 0 ? imageHeightOff:0;
            }else{
                //赋值 图片高度
                imageHeightOff = imageHeight;
            }
            //图片宽度 同上
            if imageWidth > self.frame.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right{
                imageWidthOff = self.frame.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                imageWidthOff = imageWidthOff >= 0 ? imageWidthOff:0;
            }else{
                imageWidthOff = imageWidth;
            }
            
            //设置图片大小
            imageView?.frame.size = CGSize(width: imageWidthOff, height: imageHeightOff);
            
            
            //图标的大小为主， 设置标题 宽度
            if imageWidth + titleWidth > self.frame.size.width{
                titleWidth = self.frame.size.width - imageWidth ;
                if titleWidth <= 0.0 {
                    titleWidth = 0.0;
                }
            }
            //如果标题宽度 > 布局宽度 - 标题的左右偏差
            if titleWidth > self.frame.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right{
                //重新赋值标题宽度 => 布局宽度 - 标题的左右偏差
                titleWidthOff = self.frame.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                //防止标题宽度 < 0
                titleWidthOff = titleWidthOff >= 0 ? titleWidthOff:0;
            }else{
                titleWidthOff = titleWidth;
            }
            
            
            self.titleLabel?.frame.size.width = titleWidthOff;
            //标题高度
            var titleHeight:CGFloat = 21;
            if isSuperLines {
                titleHeight = self.getTitleRect(titleLabel?.text, titleLabel!.font, CGSize(width: titleWidth, height: self.frame.size.height)).size.height;
            }
            
            if titleHeight > self.frame.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom{
                titleHeightOff = self.frame.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
                titleHeightOff = titleHeightOff >= 0 ? titleHeightOff:0;
            }else{
                titleHeightOff = titleHeight;
            }
            self.titleLabel?.frame.size.height = titleHeightOff;
            
            //获取当前内容宽度
            var contentWidth = imageWidth + titleWidth ;
            //垂直方向位置
            switch self.contentVerticalAlignment {
            case .center://垂直居中
                //图标的y坐标 =》 （布局的高度 - 图片高度）/ 一半 + 图标的偏移量  这样图片就垂直居中
                imageView?.frame.origin.y = (self.frame.size.height - imageHeight) / 2.0 + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
                //标题的Y坐标 =》 （布局高度 - 标题高度）/ 一半 + 标题的上下偏移量
                self.titleLabel?.frame.origin.y = (self.frame.size.height - titleHeight) / 2.0 + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom ;
            case .top://垂直方向向上对齐
                //图片的Y坐标 =》 图片的向上偏移量
                imageView?.frame.origin.y = 0 + self.imageEdgeInsets.top;
                //标题的Y坐标 =》 标题的向上偏移量
                self.titleLabel?.frame.origin.y = 0 + self.titleEdgeInsets.top;
                
            case .bottom://垂直方向，向下对齐
                // 图片Y坐标 =》 布局高度 - 图片高度 - 图片的向下偏移量
                imageView?.frame.origin.y = self.frame.size.height - self.imageEdgeInsets.bottom - imageHeight;
                // 标题Y坐标 =》 布局高度 - 标题高度 - 标题的向下偏移量
                self.titleLabel?.frame.origin.y = self.frame.size.height - self.titleEdgeInsets.bottom - titleHeight;
            case .fill://充满
                //重新计算标题高度
                // 新的标题高度 =》 布局高度 - 标题的向上偏移量 - 标题的向下偏移量
                var height = self.frame.size.height - self.titleEdgeInsets.bottom - self.titleEdgeInsets.top;
                //重新设置标题高度
                self.titleLabel?.frame.size.height = height < 0 ? 0:height;
                //标题的Y坐标 =》 标题的向上偏移量
                self.titleLabel?.frame.origin.y = self.titleEdgeInsets.top;
                
                //重新计算图片高度
                // 新的图片高度 =》 布局高度 - 图片的向上偏移量 - 图片的向下偏移量
                height = self.frame.size.height - self.imageEdgeInsets.bottom - self.imageEdgeInsets.top;
                self.imageView?.frame.size.height = height < 0 ? 0:height;
                self.imageView?.frame.origin.y = self.imageEdgeInsets.top;
            }
            
            if type == .Left {//图片在左边
                //水平方向 布局整理
                switch self.contentHorizontalAlignment {
                case .center://水平居中
                    //图片的x坐标 =》 （布局宽度 - 内容宽度））/ 一半  + 图片的左右偏移量
                    //注： 内容宽度 = 》（图片宽度+标题宽度
                    imageView?.frame.origin.x = (self.frame.size.width - contentWidth) / 2.0 + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                    //标题的X坐标 =》 （布局宽度 - 内容宽度）/ 一半 + 图片宽度 + 图片左右偏移量
                    self.titleLabel?.frame.origin.x = (self.frame.size.width - contentWidth) / 2.0 + imageWidth + self.titleEdgeInsets.left - self.titleEdgeInsets.right ;
                    
                case .left://水平向左对齐
                    //图片的x坐标 =》 图片的左边偏移量
                    imageView?.frame.origin.x = self.imageEdgeInsets.left;
                    //标题的X坐标 =》 图片宽度 + 标题的左边偏移量
                    self.titleLabel?.frame.origin.x = imageWidth  + self.titleEdgeInsets.left;
                    
                case .right://水平方向右对齐
                    //图片的X坐标 =》 布局的宽度 - 内容宽度 - 图片右边偏移量
                    imageView?.frame.origin.x = self.frame.size.width - contentWidth - self.imageEdgeInsets.right;
                    //标题的X坐标 =》 布局的宽度 - 标题的宽度 - 标题的右边偏移量
                    self.titleLabel?.frame.origin.x = self.frame.size.width - self.titleEdgeInsets.right - titleWidth;
                case .fill:// 水平方向充满
                    //重新计算图片宽度 与标题宽度
                    //内容宽度 =》 布局宽度
                    contentWidth = self.frame.size.width;
                    //根据标题的内容重新计算内容的宽度
                    titleWidth = self.getTitleRect(titleLabel!.text, titleLabel!.font, CGSize(width: CGFloat.greatestFiniteMagnitude, height: titleLabel!.frame.size.height)).size.width;
                    
                    //如果有图片的情况下，标题的宽度不可超出总布局宽度的一半（因为布局是以图片为主）
                    if  imageView?.image != nil && titleWidth > contentWidth  / 2.0 {
                        //如果超出布局宽度的一半 则 设置标题宽度为布局宽度的一半
                        titleWidth = contentWidth / 2.0;
                    }
                    //如果图片 不为空
                    //注：现在的内容宽度 =》 布局宽度
                    if imageView?.image != nil {
                        //设置图片的宽度为 内容宽度-标题宽度
                        imageWidth = contentWidth - titleWidth ;
                        //如果当前的图片宽度 > 内容宽度 - 图片的左右偏移量
                        if imageWidth > contentWidth - self.imageEdgeInsets.left - self.imageEdgeInsets.right{
                            //重新赋值图片宽度为 =》 内容宽度 - 图片的左右偏移量
                            imageWidth = contentWidth - self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                        }
                        ;
                    }
                    //重新设置图片宽度
                    imageView?.frame.size.width = imageWidth;
                    //图片的X坐标为 =》 图片的左边偏移量
                    imageView?.frame.origin.x = self.imageEdgeInsets.left;
                    
                    //标题宽度 => 原标题宽度 - 左右偏移量
                    if (titleWidth > contentWidth / 2.0 - self.titleEdgeInsets.left - self.titleEdgeInsets.right){
                        titleWidthOff = titleWidth - self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                        titleWidthOff = titleWidthOff >= 0 ? titleWidthOff:0;
                    }else{
                        titleWidthOff = titleWidth;
                    }
                    
                    self.titleLabel?.frame.size.width = titleWidthOff;
                    
                    
                    //标题的X左边 =》 没有图片 ？ 左边偏移量 ：布局的一半 + 左边偏移量
                    self.titleLabel?.frame.origin.x = (imageWidth == 0 ? 0 : self.frame.size.width / 2.0) + self.titleEdgeInsets.left ;
                }
                
            }else{//图片右边
                //水平方向
                switch self.contentHorizontalAlignment {
                case .center://水平居中
                    //标题的x左边 => （布局宽度 - 内容宽度）/ 一半 + 左偏移量 - 右偏移量
                    //注：内容宽度为 => 标题宽度 + 图片宽度
                    self.titleLabel?.frame.origin.x = (self.frame.size.width - contentWidth) / 2.0 + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                    //图片的x坐标 => （布局宽度 - 内容宽度）/ 一半 - 标题宽度 + 左边偏移量 - 右边偏移量
                    imageView?.frame.origin.x = (self.frame.size.width - contentWidth) / 2.0 + titleWidth + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                    
                case .left://水平左对齐
                    //标题的X坐标 => 标题的左边偏移量
                    self.titleLabel?.frame.origin.x = self.titleEdgeInsets.left;
                    //图片的x坐标 => 标题宽度 + 图片的左边偏移量
                    imageView?.frame.origin.x = titleWidth  + self.imageEdgeInsets.left;
                    
                case .right://水平靠右
                    //标题的X坐标 => 布局宽度 - 内容宽度 - 标题右边偏移量
                    self.titleLabel?.frame.origin.x = self.frame.size.width - contentWidth - self.titleEdgeInsets.right;
                    //图标的x坐标 => 布局宽度 - 图片的右边偏移量 - 图片宽度
                    imageView?.frame.origin.x = self.frame.size.width - self.imageEdgeInsets.right - imageWidth;
                case .fill://水平充满
                    //内容宽度 => 布局宽度
                    contentWidth = self.frame.size.width;
                    //标题宽度
                    titleWidth = self.getTitleRect(titleLabel?.text, titleLabel!.font, CGSize(width: CGFloat.greatestFiniteMagnitude, height: titleLabel!.frame.size.height)).size.width;
                    //标题最长不可超过一半
                    if titleWidth > contentWidth  / 2.0 {
                        titleWidth = contentWidth / 2.0;
                    }
                    if (self.imageView?.image != nil){
                        imageWidth = contentWidth - titleWidth;
                    }else{
                        imageWidth = 0
                    }
                    
                    if imageWidth > contentWidth - self.imageEdgeInsets.left - self.imageEdgeInsets.right{
                        imageWidthOff = contentWidth - self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                        imageWidthOff = imageWidthOff < 0 ? 0:imageWidthOff;
                    }else{
                        imageWidthOff = imageWidth;
                    }
                    
                    imageView?.frame.size.width = imageWidthOff;
                    
                    imageView?.frame.origin.x = (self.frame.size.width - imageWidth) + self.imageEdgeInsets.left ;
                    if titleWidth > contentWidth / 2.0 - self.titleEdgeInsets.left - self.titleEdgeInsets.right{
                        titleWidthOff = contentWidth / 2.0 - self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                        titleWidthOff = titleWidthOff >= 0 ? titleWidthOff:0;
                    }
                    self.titleLabel?.frame.size.width = titleWidthOff;
                    
                    self.titleLabel?.frame.origin.x = 0 + self.titleEdgeInsets.left;
                }
                
            }
            
        case .Top,.Bottom://图片在上面或者下面
            //计算图片大小 图片不可比按钮大
            if imageWidth > self.frame.size.width{
                imageWidth = self.frame.size.width;
                imageHeight = imageWidth / imageScale;
            }
            if imageHeight > self.frame.size.height{
                imageHeight = self.frame.size.height
                imageWidth = imageHeight * imageScale;
            }
            
            
            
            if titleWidth > self.frame.size.width{
                titleWidth = self.frame.size.width ;
                
            }
            //标题高度初始化
            var titleHeight:CGFloat = self.titleLabel!.frame.size.height;
            if isSuperLines{
                titleHeight = self.getTitleRect(titleLabel?.text, titleLabel!.font, CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude)).size.height;
            }
            if titleHeight > self.frame.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom{
                titleHeightOff = self.frame.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
                titleHeightOff = titleHeightOff >= 0 ? titleHeightOff:0;
            }else{
                titleHeightOff = titleHeight;
            }
            self.titleLabel?.frame.size.height = titleHeightOff;
            self.titleLabel?.frame.size.width = titleWidth;
            
            //水平方向处理
            switch self.contentHorizontalAlignment {
            case .center:
                self.imageView?.frame.origin.x = (self.frame.size.width - imageWidth ) / 2.0 + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                self.titleLabel?.frame.origin.x = (self.frame.size.width - titleWidth ) / 2.0 + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                
            case .left:
                
                self.titleLabel?.frame.origin.x = 0 + self.titleEdgeInsets.left;
                imageView?.frame.origin.x = 0 + self.imageEdgeInsets.left;
                
            case .right:
                
                self.titleLabel?.frame.origin.x = self.frame.size.width - titleWidth - self.titleEdgeInsets.right;
                imageView?.frame.origin.x = self.frame.size.width - self.imageEdgeInsets.right - imageWidth;
            case .fill:
                imageWidth = self.frame.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right;
                
                imageView?.frame.size.width = imageWidth;
                imageView?.frame.origin.x = (self.frame.size.width - imageWidth) + self.imageEdgeInsets.left - self.imageEdgeInsets.right
                
                titleWidth = self.frame.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right;
                if isSuperLines{
                    //重新计算高度
                    titleHeight = self.getTitleRect(titleLabel?.text, titleLabel!.font, CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude)).size.height;
                    titleLabel?.frame.size.height = titleHeight;
                }
                
                imageView?.frame.size.width = titleWidth;
                titleLabel?.frame.origin.x = (self.frame.size.width - titleWidth) + self.titleEdgeInsets.left - self.titleEdgeInsets.right
                
            }
            
            
            if titleHeight + imageHeight > self.frame.size.height{
                titleHeight = self.frame.size.height - imageHeight;
                if(titleHeight < 0){
                    titleHeight = 0;
                }
            }
            titleLabel?.frame.size.height = titleHeight;
            var conetntHeight = imageHeight + titleHeight
            
            if type == .Top{//图片在顶部
                //垂直方向位置
                switch self.contentVerticalAlignment {
                case .center:
                    imageView?.frame.origin.y = (self.frame.size.height - conetntHeight) / 2.0 + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
                    self.titleLabel?.frame.origin.y = (self.frame.size.height - conetntHeight) / 2.0 + imageHeight + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom ;
                    
                case .top:
                    
                    imageView?.frame.origin.y = 0 + self.imageEdgeInsets.top;
                    self.titleLabel?.frame.origin.y = 0 + imageHeight + self.titleEdgeInsets.top;
                    
                case .bottom:
                    
                    imageView?.frame.origin.y = self.frame.size.height - self.imageEdgeInsets.bottom - imageHeight - titleHeight;
                    self.titleLabel?.frame.origin.y = self.frame.size.height - self.titleEdgeInsets.bottom - self.titleLabel!.frame.size.height;
                    
                case .fill:
                    self.imageView?.frame.origin.y = self.imageEdgeInsets.top;
                    if imageHeight > 0 && titleHeight > self.frame.size.height/2{
                        titleHeight = self.frame.size.height/2;
                    }
                    if imageHeight > 0 {
                        imageHeight = self.frame.size.height - titleHeight;
                    }
                    self.imageView?.frame.size.height = imageHeight;
                    self.imageView?.frame.origin.y = self.imageEdgeInsets.top;
                    
                    
                    self.titleLabel?.frame.size.height = titleHeight;
                    self.titleLabel?.frame.origin.y = (imageHeight == 0 ? 0 :self.frame.size.height / 2.0) + self.titleEdgeInsets.top;
                    
                    
                    
                }
                
            }else{
                //垂直方向位置
                switch self.contentVerticalAlignment {
                case .center:
                    
                    self.titleLabel?.frame.origin.y = (self.frame.size.height - conetntHeight) / 2.0 + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom ;
                    
                    imageView?.frame.origin.y = (self.frame.size.height - conetntHeight) / 2.0 + titleHeight +  self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
                    
                    
                case .top:
                    
                    self.titleLabel?.frame.origin.y =  self.titleEdgeInsets.top;
                    imageView?.frame.origin.y =  titleHeight + self.imageEdgeInsets.top;
                    
                case .bottom:
                    
                    imageView?.frame.origin.y = self.frame.size.height - self.imageEdgeInsets.bottom - imageHeight;
                    self.titleLabel?.frame.origin.y = self.frame.size.height - self.titleEdgeInsets.bottom - titleHeight - imageHeight;
                    
                case .fill:
                    
                    self.imageView?.frame.origin.y = self.imageEdgeInsets.top;
                    if imageHeight > 0 && titleHeight > self.frame.size.height/2{
                        titleHeight = self.frame.size.height/2;
                    }
                    if imageHeight > 0 {
                        imageHeight = self.frame.size.height - titleHeight;
                    }
                    self.imageView?.frame.size.height = imageHeight;
                    self.imageView?.frame.origin.y = self.frame.size.height - self.imageEdgeInsets.top - imageHeight;
                    
                    
                    self.titleLabel?.frame.size.height = titleHeight;
                    self.titleLabel?.frame.origin.y = 0 + self.titleEdgeInsets.top;
                    
                    
                    
                }
                
                
            }
            
            
        default:
            print("");
        }
        
        
        
        
    }
    
    private var isSuperLines:Bool = false;
    
    func isSuperLines(_ _isSuperLines:Bool){
        self.isSuperLines = _isSuperLines;
        //刷新UI
        self.setNeedsDisplay();
    }
    
    
    private func getTitleRect(_ text:String?,_ font:UIFont,_ size:CGSize) -> CGRect{
        if text == nil {
            return CGRect.zero;
        }
        let attributes = [NSFontAttributeName:font];
        let nsString = NSString(string: text!)
        return nsString.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil);
    }
    
}
