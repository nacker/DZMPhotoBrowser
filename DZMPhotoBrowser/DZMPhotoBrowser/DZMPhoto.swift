//
//  DZMPhoto.swift
//  DZMPhotoBrowser
//
//  Created by haspay on 16/3/22.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class DZMPhoto: NSObject {

    // MARK: - 图片相关
    var url:NSURL?                          // 需要加载的图片url 假如URL没值 则使用ImageView上的图片显示 (url  imageview 必须一个有值)
    var imageView:UIImageView!              // 图片来源于哪个ImageView 假如ImageView没值 隐藏的时候动画消失 (url  imageview 必须一个有值)
    
    
    
    
    // MARK: - 扩展操作
    var image:UIImage?                      // 当前模型显示的图片 不需要外部赋值
    var index:NSInteger!                    // 图片当前的索引
    var firstShow:Bool = false              // 改图片是否第一次显示
    var save:Bool = false                   // 是否保存到相册
}
