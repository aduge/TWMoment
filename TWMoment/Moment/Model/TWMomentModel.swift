//
//  TWMomentModel.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

class TWMomentModel: NSObject {
    
    // 评论数组
    var commentArray: NSArray?
    // 内容
    var content: String?
    // 照片数组
    var imageArray: NSArray?
    // 发送者
    var sender: TWMomentSenderModel?
    
    // 显示/收起 全文
    var isFullText: Bool?
    // Moment对应的cell高度
    var rowHeight: CGFloat?
}
