//
//  DZMScrollView.swift
//  DZMPhotoBrowser
//
//  Created by haspay on 16/3/22.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

protocol DZMScrollViewDelegate:NSObjectProtocol {
    func scrollView(scrollView:DZMScrollView,imageDownloadComplete photo:DZMPhoto)
}

class DZMScrollView: UIScrollView,UIScrollViewDelegate {
    
    weak var aDelegate:DZMScrollViewDelegate?
    var photo:DZMPhoto!{                                    // 模型数据
        didSet{
            // 有链接
            if photo.url != nil {
        
                if photo.imageView != nil {
                    imageView.image = photo.imageView.image
                    adjustFrame()
                }
                
                imageView.sd_setImageWithURL(photo.url, placeholderImage: photo.imageView?.image, completed: { [weak self](image, error, imageCacheType, url) -> Void in
                    if image != nil { // 下载完成
                        self!.photo.image = image
                        self!.adjustFrame()
                        self!.aDelegate?.scrollView(self!, imageDownloadComplete: self!.photo)
                    }
                    
                    })
            }else{
                
                if photo.imageView != nil {
                    photo.image = photo.imageView.image
                    imageView.image = photo.imageView.image
                }
                adjustFrame()
            }
        }
    }
    
    private var imageView:UIImageView!                      // 图片
    private var singleTap:UITapGestureRecognizer!           // 隐藏点击
    private var doubleTap:UITapGestureRecognizer!           // 放大点击
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        backgroundColor = UIColor.clearColor()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        decelerationRate = UIScrollViewDecelerationRateFast
        autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        
        creatUI()
    }
    
    // 新建UI
    func creatUI() {
        imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        addSubview(imageView)
        
        // 添加手势
        singleTap = UITapGestureRecognizer(target: self, action: #selector(DZMScrollView.handleSingleTap(_:)))
        singleTap.delaysTouchesBegan = true
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
        
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(DZMScrollView.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        singleTap.requireGestureRecognizerToFail(doubleTap)
    }
    
    // MARK: -  手势操作
    
    func handleSingleTap(tap:UITapGestureRecognizer) {
     
        UIView.animateWithDuration(DZMWindow.shareWindow.animateDuration, animations: { [weak self]() -> Void in
            DZMWindow.shareWindow.myWindow.alpha = 0
            
            if self!.zoomScale == self!.maximumZoomScale {
                self!.zoomScale = self!.minimumZoomScale
            }
            
            if self!.photo.imageView != nil {  // 有imageview 的消失效果
                
                self!.imageView.image = self!.photo.imageView.image
                self!.imageView.frame = self!.photo.imageView.convertRect(self!.photo.imageView.bounds, toView: nil)
                
            }else{  // 无imageview的消失效果
                
                self!.imageView.alpha = 0
            }
            
            }) { (isOK) -> Void in
                DZMWindow.shareWindow.hidden()
        }
    }
    
    func handleDoubleTap(tap:UITapGestureRecognizer) {
    
//        let touchPoint = tap.locationInView(self)
        
        if zoomScale == maximumZoomScale {
            setZoomScale(minimumZoomScale, animated: true)
        }else{
            setZoomScale(maximumZoomScale, animated: true)
//            zoomToRect(CGRectMake(touchPoint.x, touchPoint.y, 1, 1), animated: true)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        var imageViewFrame = imageView.frame
        let screenBounds = UIScreen.mainScreen().bounds
        
        if imageViewFrame.size.height > screenBounds.size.height {
            imageViewFrame.origin.y = 0
        }else{
            imageViewFrame.origin.y = (screenBounds.size.height - imageViewFrame.size.height)/2
        }
        imageView.frame = imageViewFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: -  调整Frame
    func adjustFrame() {
        
        // 没有图片
        if imageView.image == nil {return}
        
        // 设置尺寸参数
        let boundsSize = UIScreen.mainScreen().bounds.size
        let boundsWidth = boundsSize.width
        let boundsHeight = boundsSize.height
        
        let imageSize = imageView.image!.size
        let imageWidth = imageSize.width
        let imageHeight = imageSize.height
        
        // 计算伸缩比例
        var minScale:CGFloat = boundsWidth / imageWidth
        if minScale > 1 {minScale = 1.0}
        var maxScale:CGFloat = 2.0
        if UIScreen.instancesRespondToSelector(#selector(NSDecimalNumberBehaviors.scale)) {
            maxScale = maxScale / UIScreen.mainScreen().scale
        }
        
        maximumZoomScale = maxScale
        minimumZoomScale = minScale
        zoomScale = minScale
        
        var imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth)
        contentSize = CGSizeMake(0, imageFrame.height)
        
        imageFrame.origin.y = floor((boundsHeight - imageFrame.height)/2)
        
        if photo.imageView != nil {
            imageView.contentMode = photo.imageView.contentMode
        }
        
        // 默认位置
        imageView.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2, 1, 1)
        
        if photo.firstShow { // 首次显示图片
            
            photo.firstShow = false
            
            if photo.imageView != nil {
                imageView.frame = photo.imageView!.convertRect(photo.imageView!.bounds, toView: nil)
            }
            
            UIView.animateWithDuration(DZMWindow.shareWindow.animateDuration, animations: { [weak self]() -> Void in
                self!.imageView.frame = imageFrame
                })
            
        }else{  // 非首次显示
            
            imageView.frame = imageFrame
        }
    }
    
    deinit{
        
        debugPrint("DZMScrollView 释放了")
        
        aDelegate = nil
        
        removeGestureRecognizer(singleTap)
        removeGestureRecognizer(doubleTap)
        
        imageView.removeFromSuperview()
        imageView = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
