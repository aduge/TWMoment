//
//  Constant.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

// 屏幕设置系列
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenBounds = UIScreen.main.bounds

let kStatubarHeight = UIApplication.shared.statusBarFrame.size.height   //状态栏高度
let kNavBarHeight: CGFloat = 44.0   //导航栏高度
let kTabBarHeight = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49  //底部tabbar高度
let kTopHeight = (kStatubarHeight + kNavBarHeight)  //状态栏+导航栏高度

// 头像视图的宽、高
let kFaceWidth        =    40
// 顶部和底部的留白
let kBlnk             =    15
// 右侧空白
let kRightMargin      =    15
// 正文字体
let kTextFont         =    UIFont.systemFont(ofSize: 15)
// 内容视图宽度
let kTextWidth        =    kScreenWidth - 60 - 25
// 图片间距
let kImagePadding     =    5
// 图片宽度
let kImageWidth       =    75
// 全文/收起按钮高度
let kMoreLabHeight    =    20
// 全文/收起按钮宽度
let kMoreLabWidth     =    60
// 视图之间的间距
let kPaddingValue     =    8
// 评论赞视图气泡的冒尖高度
let kArrowHeight      =    5

