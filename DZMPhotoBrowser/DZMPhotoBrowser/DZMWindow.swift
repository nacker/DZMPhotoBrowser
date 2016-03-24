//
//  DZMWindow.swift
//  DZMPhotoBrowser
//
//  Created by haspay on 16/3/22.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class DZMWindow: NSObject {
    
    var animateDuration = 0.25
    var myWindow:UIWindow!                              // 当前window
    private var showViewController:UIViewController?    // 显示的控制器
    private var showView:UIView?                        // 显示view
    
    
    /// 获取单例对象 DZMWindow
    class var shareWindow : DZMWindow {
        struct Static {
            static let instance : DZMWindow = DZMWindow.ShareWindow()
        }
        return Static.instance
    }
    
    /// 初始化方法
    private class func ShareWindow() ->DZMWindow {
        let window = DZMWindow()
        window.creatWindow()
        return window
    }
    
    /// 创建Window
    private func creatWindow() ->UIWindow {
        
        if myWindow == nil {
            
            // 初始化window
            myWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
            myWindow.backgroundColor = UIColor.blackColor()
            
            // 遮住状态 不需要遮住去掉即可
            myWindow.windowLevel = UIWindowLevelAlert
            
            myWindow.alpha = 0
            myWindow.hidden = true
        }
        return myWindow
    }
    
    /// 显示一个view
    func showView(view:UIView) {
    
        showView = view
        
        myWindow.addSubview(view)
        
        myWindow.hidden = false
        
        UIView.animateWithDuration(animateDuration) { [weak self]() -> Void in
            
            self!.myWindow.alpha = 1
        }
    }
    
    /// 显示一个viewController
    func showViewController(viewController:UIViewController) {
        
        showViewController = viewController
        
        myWindow.addSubview(viewController.view)
        
        myWindow.hidden = false
        
        UIView.animateWithDuration(animateDuration) { [weak self]() -> Void in
            
            self!.myWindow.alpha = 1
        }
    }
    
    func hidden() {
        
        // 清理window
        for subview in myWindow.subviews {
            subview.removeFromSuperview()
        }
        
        if showView != nil {
            showView = nil
        }
        
        if showViewController != nil {
            showViewController!.removeFromParentViewController()
            showViewController = nil
        }
        
        myWindow.alpha = 0
        myWindow.hidden = true
    }
}

