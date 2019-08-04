//
//  TWHttpNetwork.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation

typealias completionBlock = (_ data : Optional<Any>? ) -> ()

class TWHttpNetwork: NSObject {
    
    class func get(urlString:String, completion:@escaping completionBlock) -> URLSessionDataTask {
        let newUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let config = URLSessionConfiguration.default
        let url = URL(string: newUrlString!)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data,response,error) in
            let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            completion(result)
        }
        task.resume()
        return task
    }
    
    
    class func post(urlString:String, params:NSDictionary, completion:@escaping completionBlock) {
        
        //发送POST请求NSURLSession
        //对请求路径的说明
        //http://120.25.226.186:32812/login
        //协议头+主机地址+接口名称
        //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)
        //POST请求需要修改请求方法为POST，并把参数转换为二进制数据设置为请求体
        
        //1.创建会话对象
        let session: URLSession = URLSession.shared
        
        //2.根据会话对象创建task
        let url: NSURL = NSURL(string: urlString)!
        
        //3.创建可变的请求对象
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        
        let list  = NSMutableArray()
        
        //5.设置请求体
        if params.count > 0 {
            //设置为POST请求
            request.httpMethod = "POST"
            //拆分字典,subDic是其中一项，将key与value变成字符串
            for subDic in params {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.add(tmpStr)
            }
            //用&拼接变成字符串的字典各项
            let paramStr = list.componentsJoined(by: "&")
            //UTF8转码，防止汉字符号引起的非法网址
            let paraData = paramStr.data(using: String.Encoding.utf8)
            //设置请求体
            request.httpBody = paraData
        }
        
        //6.根据会话对象创建一个Task(发送请求）
        /* 第一个参数：请求对象 第二个参数：completionHandler回调（请求完成【成功|失败】的回调） data：响应体信息（期望的数据） response：响应头信息，主要是对服务器端的描述 error：错误信息，如果请求失败，则error有值 */
        let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //if(error == nil){
            //8.解析数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            let dict  = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
            completion(dict)
        }
        //5.执行任务
        dataTask.resume()
        
    }
    
}
