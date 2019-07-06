//
//  TWWebImage.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /**
     *设置web图片
     *url:图片路径
     *defaultImage:默认缺省图片
     *isCache：是否进行缓存的读取
     */
    func setWebImage(url:NSString?, defaultImage:NSString?, isCache:Bool){
        var image:UIImage?
        if url == nil {
            return
        }
        //设置默认图片
        if defaultImage != nil {
            self.image=UIImage(named: defaultImage! as String)
        }
        
        if isCache {
            let data:NSData?=TWWebImageChche.readCacheFromUrl(url: url!)
            if data != nil {
                image=UIImage(data: data! as Data)
                self.image=image
            }
            else{
                let queue=DispatchQueue.global()
                queue.async {
                    let URL:NSURL = NSURL(string: url! as String)!
                    let data:NSData?=NSData(contentsOf: URL as URL)
                    if data != nil {
                        image=UIImage(data: data! as Data)
                        //写缓存
                        TWWebImageChche.writeCacheToUrl(url: url!, data: data!)
                        DispatchQueue.main.async {
                            //刷新主UI
                            self.image=image
                        }
                    }
                    
                }
            }
        }
        else{
            let queue=DispatchQueue.global()
            queue.async {
                let URL:NSURL = NSURL(string: url! as String)!
                let data:NSData?=NSData(contentsOf: URL as URL)
                if data != nil {
                    image=UIImage(data: data! as Data)
                    DispatchQueue.main.async {
                        self.image=image
                    }
                }
            }
        }
    }
    
}

