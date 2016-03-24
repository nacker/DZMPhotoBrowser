# DZMPhotoBrowser
实现简单 支持无URL图片 或者 无指定imageView UIButton 又或者三者交叉 图片展示 都有动画效果展示隐藏 需要导入SDWebImage

![CarouselView in action](Untitled.gif)

## 可选功能
图片保存相册成功的提示有需求的话就自己加 DZMPhotoBrowser 文件的这个方法里面添加判断已做好 UI效果都有 提示效果可自己添加
func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>)

现在是无页面提示文字显示 需要显示 可在
func scrollViewDidScroll(scrollView: UIScrollView) 方法添加 总页面跟当前页面 已写好



支持无URL图片 或者 无指定imageView 又或者两者交叉 图片展示 都有动画效果展示隐藏

现在无imageview 直接alpha = 0 动画消失 如需改动动画 DZMScrollView 页面的这个方法进行改动
func handleSingleTap(tap:UITapGestureRecognizer)

##期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢!
* 如果在使用过程中发现功能不够用，希望你能Issues我.