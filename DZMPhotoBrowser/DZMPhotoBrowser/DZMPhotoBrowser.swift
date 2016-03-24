//
//  DZMPhotoBrowser.swift
//  DZMPhotoBrowser
//
//  Created by haspay on 16/3/22.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit
protocol DZMPhotoBrowserDelegate:NSObjectProtocol {
    // 切换图片的时候调用
    func photoBrowser(photoBrowser:DZMPhotoBrowser,currentIndex:NSInteger, currentPhoto:DZMPhoto)
}
class DZMPhotoBrowser: UIViewController,UIScrollViewDelegate,DZMScrollViewDelegate {
    
    /// 代理
    weak var delegate:DZMPhotoBrowserDelegate?
    
    /// 传入所有的图片对象
    var photos:[DZMPhoto] = []
    
    /// 当前需要选中 photos 中照片 的索引
    var currentPhotoIndex:NSInteger = 0
    
    
    
    // MARK: - 私有属性
    private var photoScrollView:UIScrollView!
    private var myWindow:UIWindow!
    private var saveButton:UIButton!
    private var currentIndex:NSInteger = 0              // 记录当前显示的图片是第几张
    private var currentPhoto:DZMPhoto!                  // 记录当前显示的图片模型
    private var currentScrollView:DZMScrollView!        // 记录当前显示的DZMScrollView
    private var space:NSInteger = 1
    private var saveStatus:Bool = false                 // 防止多次点击保存
    private var scrollviewSpaceW:CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化创建UI
        creatUI()
        
        // 有滚动的控件想要00从状态栏开始需要设置该属性为false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    
    /// 初始化创建UI
    func creatUI() {
        
        var frame = UIScreen.mainScreen().bounds
        frame.origin.x -= scrollviewSpaceW
        frame.size.width += 2*scrollviewSpaceW
        photoScrollView = UIScrollView()
        photoScrollView.delegate = self
        photoScrollView.pagingEnabled = true
        photoScrollView.backgroundColor = UIColor.clearColor()
        photoScrollView.showsHorizontalScrollIndicator = false
        photoScrollView.showsVerticalScrollIndicator = false
        photoScrollView.frame = frame
        photoScrollView.contentSize = CGSizeMake(CGFloat(photos.count) * frame.size.width, 0)
        view.addSubview(photoScrollView)
        
        // 保存按钮
        saveButton = UIButton(type: UIButtonType.Custom)
        saveButton.adjustsImageWhenHighlighted = false
        saveButton.setImage(UIImage(named: "save"), forState: UIControlState.Normal)
        saveButton.addTarget(self, action: #selector(DZMPhotoBrowser.saveImage), forControlEvents: UIControlEvents.TouchUpInside)
        let saveButtonWH:CGFloat = 35
        saveButton.frame = CGRectMake((UIScreen.mainScreen().bounds.width - saveButtonWH)/2, UIScreen.mainScreen().bounds.height - saveButtonWH - 20, saveButtonWH, saveButtonWH)

        // 摆放图片
        for i in 0 ..< photos.count {
            let photo = photos[i]
            photo.index = i                                     // 索引
            photo.firstShow = i == currentPhotoIndex            // 设置是否首次显示
            
            // 创建显示view
            let scrollView = DZMScrollView()
            scrollView.tag = (i + space)
            scrollView.aDelegate = self
            scrollView.photo = photo
            photoScrollView.addSubview(scrollView)
            scrollView.frame = CGRectMake(CGFloat(i) * frame.size.width + scrollviewSpaceW, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        }
        
        
        // 初始化索引
        if currentPhotoIndex == 0 {
            // 默认中
            scrollViewDidScroll(photoScrollView)
        }else{
            photoScrollView.contentOffset = CGPointMake(CGFloat(currentPhotoIndex) * frame.size.width, 0)
        }
     
        // 最后添加按钮确保显示最上层
        view.addSubview(saveButton)
    }
    
    // MARK: - DZMScrollViewDelegate
    func scrollView(scrollView: DZMScrollView, imageDownloadComplete photo: DZMPhoto) {
        if currentIndex == scrollView.tag {
            if !currentPhoto.save && currentPhoto.url != nil {
                saveButton.enabled = currentPhoto.image == nil ? false : true
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / (scrollView.frame.width) + 0.5) + space
        
        if page != currentIndex {
            
            // 切换的时候回到最小图片
            if currentScrollView != nil && currentScrollView.zoomScale != currentScrollView.minimumZoomScale {
                currentScrollView.adjustFrame()
            }
            
            currentPhoto = photos[(page - space)]
            currentIndex = page
            currentScrollView = photoScrollView.subviews[(page - space)] as! DZMScrollView
            
            
            // 添加页面可在这里 currentIndex: 当前页码  photos.count:总页码
            
            if !currentPhoto.save && currentPhoto.url != nil {
                saveButton.enabled = currentPhoto.image == nil ? false : true
            }else{
                saveButton.enabled = !currentPhoto.save
            }
            
            // 开启能够保存图片
            if saveButton.enabled {saveStatus = false}
            
            delegate?.photoBrowser(self, currentIndex: (currentIndex - space), currentPhoto: currentPhoto)
        }
    }
    
    /// 显示操作
    func show() {
        DZMWindow.shareWindow.showViewController(self)
    }
    
    /// 保存到相册
    func saveImage() {
        
        if saveStatus {return}
        saveStatus = true
        
        UIImageWriteToSavedPhotosAlbum(currentPhoto.image!, self, #selector(DZMPhotoBrowser.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // 保存结果
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        
        if error != nil { // 保存失败
            
        }else{  // 保存成功
            currentPhoto.save = true
            saveButton.enabled = false
        }
    }
    
    deinit{
        
        debugPrint("DZMPhotoBrowser 释放了")
        
        photos.removeAll()
        photoScrollView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
