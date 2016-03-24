//
//  ViewController.swift
//  DZMPhotoBrowser
//
//  Created by haspay on 16/3/22.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var urls:[String] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  xcode 7.3   swift2.2
         需要导入SDWebImage  图片保存相册成功的提示有需求的话就自己加 DZMPhotoBrowser 文件的这个方法里面添加判断已做好 UI效果都有 提示效果可自己添加
         func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>)
         
         现在是无页面提示文字显示 需要显示 可在
         func scrollViewDidScroll(scrollView: UIScrollView) 方法添加 总页面跟当前页面 已写好

         
         
         支持无URL图片 或者 无指定imageView UIButton 又或者三者交叉 图片展示 都有动画效果展示隐藏
         注意啊 ： 按钮的imageview没有图片frame是没有size的 这样就没法从按钮图片位置处动画展示 注意保证按钮是有size的
         
         现在无imageview 直接alpha = 0 动画消失 如需改动动画 DZMScrollView 页面的这个方法进行改动
         func handleSingleTap(tap:UITapGestureRecognizer)
         */
        
        
        // 图片URL
        urls = ["http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
            "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
            "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
            "http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
            "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
            "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
            "http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
            "http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
            "http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
            "http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg"]
        
        
        // 创建ImageView ImageView 自己添加点击手势  或者 UIButton(按钮则在设置ImageView的时候使用按钮内部自带的ImageView即可)
        let width:CGFloat = 100
        let height:CGFloat = 100
        let margin:CGFloat = 20
        let startX = (view.frame.size.width - 3 * width - 2 * margin)/2
        let startY:CGFloat = 30
        
//        // imageView
//        for i in 0 ..< urls.count {
//            let imageView = UIImageView()
//            imageView.backgroundColor = UIColor.redColor()
//            scrollView.addSubview(imageView)
//            
//            // 位置
//            let row = i/3
//            let col = i%3
//            imageView.frame = CGRectMake(startX + CGFloat(col)*(width + margin), startY + CGFloat(row) * (height + margin), width, height)
//            imageView.sd_setImageWithURL(NSURL(string: urls[i]))
//            
//            // 监听事件
//            imageView.tag = i
//            imageView.userInteractionEnabled = true
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapImage(_:))))
//            
//            scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(imageView.frame))
//        }
        
        // button
        for i in 0 ..< urls.count {
            let imageButton = UIButton(type: UIButtonType.Custom)
            imageButton.backgroundColor = UIColor.redColor()
            scrollView.addSubview(imageButton)
            
            // 位置
            let row = i/3
            let col = i%3
            imageButton.frame = CGRectMake(startX + CGFloat(col)*(width + margin), startY + CGFloat(row) * (height + margin), width, height)
//            imageButton.sd_setImageWithURL(NSURL(string: urls[i]), forState: UIControlState.Normal)
            imageButton.setImage(UIImage(named: "22.jpg"), forState: UIControlState.Normal)
//            imageButton.setImage(UIImage(named: "save.png"), forState: UIControlState.Normal)
            
            // 监听事件
            imageButton.tag = i
            imageButton.addTarget(self, action: #selector(ViewController.tapButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(imageButton.frame))
        }

    }
    
    
    // 按钮点击
    func tapButton(button:UIButton) {
        
        var photos:[DZMPhoto] = []
        
        // 转换模型 多张图片
        for i in 0  ..< urls.count  {
            
            let photo = DZMPhoto()
            let url = urls[i].stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
            
            // 这行可以注销试试看
//            photo.url = NSURL(string: url)
            
            // 这行可以注销试试看
//                        if i < 2 {  // 测试 假如图片过多 2张以后没有imageview 消失效果 意思就是：前2张有imageview的消失的时候会回到原图位置  没有imageview的则直接动画消失
            
            // 这行可以注销试试看
            photo.imageView = (scrollView.subviews[i] as! UIButton).imageView
//                        }
            
            photos.append(photo)
        }
        
        showPhotoBrowser(button, photos: photos)
    }
    
    
    // 图片点击
    func tapImage(tap:UITapGestureRecognizer) {
        
        var photos:[DZMPhoto] = []
        
        // 转换模型 多张图片
        for i in 0  ..< urls.count  {
            
            let photo = DZMPhoto()
            let url = urls[i].stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
            
            // 这行可以注销试试看
            photo.url = NSURL(string: url)
            
            // 这行可以注销试试看
            //            if i < 2 {  // 测试 假如图片过多 2张以后没有imageview 消失效果 意思就是：前2张有imageview的消失的时候会回到原图位置  没有imageview的则直接动画消失
            
            // 这行可以注销试试看    注意啊 ： 按钮的imageview没有图片frame是没有size 的 这样就没法从按钮图片位置处动画展示 注意保证按钮是有size的
            photo.imageView = scrollView.subviews[i] as! UIImageView
            //            }
            
            photos.append(photo)
        }
        
        showPhotoBrowser(tap.view!, photos: photos)
    }
    
    // 使用显示代码
    func showPhotoBrowser(tapView:UIView , photos:[DZMPhoto]) {
        
        
        // 显示
        let photoBrowser = DZMPhotoBrowser()
        photoBrowser.photos = photos
        photoBrowser.currentPhotoIndex = tapView.tag
        photoBrowser.show()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

