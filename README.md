# XButton
支持图片各个方向的按钮
# 使用方法
## 与原生的UIButton的使用方法一样,只是新增了 一个 type属性 用于设置 图片的方向,分别支持 向左，右，上，下 四个方向
```code swift
  let xBtn = XButton();
  //设置图片的位置
  xBtn.type = .Left //.Top .Left .Right .Bottom
  //设置标题是否支持多行
  xBtn.isSuperLines = true;
```
![示例图片](https://github.com/xiaoGoO/XButton/blob/master/MySwift/IMG/XButton.gif)
