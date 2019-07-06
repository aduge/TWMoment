//
//  TWImageListView.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

// 图片显示集合
class TWImageListView: UIView {
    
    // 动态
    var moment: TWMomentModel! {
        
        didSet {
            
            imageViewsAry.enumerateObjects { (objc, index, stop) in
                
                let imageView: MMImageView = objc as! MMImageView
                imageView.isHidden = true
            }
            
            // 图片区域
            let count:Int = Int(moment.imageArray?.count ?? 0)
            if count == 0 {
                
                self.size = .zero
                return
            }
            
            // 添加图片
            var imageView: MMImageView!
            for i in 0..<count {
                
                if i > 8 {
                    break
                }
                
                var rowNum = i / 3
                var colNum = i % 3
                if count == 4 {
                    
                    rowNum = i / 2
                    colNum = i % 2
                }
                
                let imageX = colNum * (kImageWidth + kImagePadding)
                let imageY = rowNum * (kImagePadding + kImageWidth)
                var frame = CGRect(x: imageX, y: imageY, width: kImageWidth, height: kImageWidth)
                
                // 单张图片需要计算实际显示Size
                if count == 1 {
                    
                    let singleSize = TWUtility.getSingleSize(singleSize: CGSize(width: 500, height: 315))
                    frame = CGRect(x: 0.0, y: 0.0, width: singleSize.width, height: singleSize.height)
                }
                
                imageView = self.viewWithTag(1000 + i) as? MMImageView
                imageView.isHidden = false
                imageView.frame = frame
                imageView.setWebImage(url: moment.imageArray?.object(at: i) as! NSString?, defaultImage: nil, isCache: true)
            }
            
            self.width = kTextWidth
            self.height = imageView.bottom
        }
    }
    // 图片视图数组
    var imageViewsAry: NSMutableArray!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载视图
    func addContentView() {
        
        imageViewsAry = NSMutableArray()
        
        for i in 0..<9 {
            
            let imageView = MMImageView(frame: .zero)
            imageView.tag = 1000 + i
      
            imageViewsAry.add(imageView)
            self.addSubview(imageView)
        }
        
    }
    
}

// 单个小图显示视图
class MMImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载视图
    func addContentView() {
        
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.contentScaleFactor = UIScreen.main.scale
        self.isUserInteractionEnabled = true
        
    }
    
}


