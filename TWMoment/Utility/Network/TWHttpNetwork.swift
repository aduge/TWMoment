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
    
    class func get(urlString:String, completion:@escaping completionBlock) {
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
    }
    
}
