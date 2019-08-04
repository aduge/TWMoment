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
            if (data != nil) {
                let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                completion(result)
            }
        }
        task.resume()
        return task
    }
    
    
    class func post(urlString:String, params:NSDictionary, completion:@escaping completionBlock) {
        
        let session: URLSession = URLSession.shared
        let url: NSURL = NSURL(string: urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        let list  = NSMutableArray()
    
        if params.count > 0 {
            request.httpMethod = "POST"
            for subDic in params {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.add(tmpStr)
            }
            let paramStr = list.componentsJoined(by: "&")
            let paraData = paramStr.data(using: String.Encoding.utf8)
            request.httpBody = paraData
        }
        
        let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let dict  = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
            completion(dict)
        }
        dataTask.resume()
    }
    
}
