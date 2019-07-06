//
//  TWWebImageCache.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit
import Foundation

class TWWebImageChche: NSObject {
    
    class func readCacheFromUrl(url:NSString)->NSData?{
        var data:NSData?
        let path:NSString=TWWebImageChche.getFullCachePathFromUrl(url: url)
        if FileManager.default.fileExists(atPath: path as String) {
            do {
                data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.alwaysMapped)
            }
            catch {
                data = nil
            }
        }
        return data
    }
    
    class func writeCacheToUrl(url:NSString, data:NSData){
        let path:NSString=TWWebImageChche.getFullCachePathFromUrl(url: url)
        print(data.write(toFile: path as String, atomically: true))
    }
    
    //设置缓存路径
    class func getFullCachePathFromUrl(url:NSString)->NSString{
        var chchePath=NSHomeDirectory().appendingFormat("/Library/Caches/MyCache")
        let fileManager:FileManager=FileManager.default
        fileManager.fileExists(atPath: chchePath)
        if !(fileManager.fileExists(atPath: chchePath)) {
            try? fileManager.createDirectory(atPath: chchePath, withIntermediateDirectories: true, attributes: nil)
        }
        //进行字符串处理
        var newURL:NSString
        newURL=TWWebImageChche.stringToString(str: url)
        chchePath=chchePath.appendingFormat("/%@", newURL)
        return chchePath as NSString
    }
    
    //删除缓存
    class func removeAllCache(){
        let chchePath=NSHomeDirectory().appendingFormat("/Library/Caches/MyCache")
        let fileManager:FileManager=FileManager.default
        if fileManager.fileExists(atPath: chchePath) {
            try? fileManager.removeItem(atPath: chchePath)
        }
        
    }
    
    class func stringToString(str:NSString)->NSString{
        let newStr:NSMutableString=NSMutableString()
        for i in 0...str.length-1 {
            let c:unichar=str.character(at: i)
            if (c>=48&&c<=57)||(c>=65&&c<=90)||(c>=97&&c<=122){
                newStr.appendFormat("%c", c)
            }
        }
        return newStr.copy() as! NSString
    }
}

