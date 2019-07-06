//
//  TWHttpBusinessWork.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

class TWMomentNetwork: NSObject {
    
    class func getUserInformation(completion: @escaping (_ model: TWMomentUserModel) -> ()) {
        TWHttpNetwork.get(urlString:"https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith") { (data :Optional<Any>?) in
            if data is NSDictionary {
                let dictionary = data as! NSDictionary
                let userModel = TWMomentUserModel()
                userModel.profileImage = dictionary.object(forKey: "profile-image") as? String
                userModel.avatar = dictionary.object(forKey: "avatar") as? String
                userModel.userName = dictionary.object(forKey: "username") as? String
                userModel.nick = dictionary.object(forKey: "nick") as? String
                completion(userModel)
            }
        }
    }
    
    
    class func getMomentArray(completion: @escaping (_ array: NSArray) -> ()) {
        TWHttpNetwork.get(urlString:"https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets") { (data : Optional<Any>?) in
            
            let resultArray = NSMutableArray()
            if let tweetArray: NSArray = data as? NSArray
            {
                for tweet in tweetArray {
                    if let tweetDic: NSDictionary = tweet as? NSDictionary {
                        
                        let momentModel = TWMomentModel()
                        momentModel.content = tweetDic.object(forKey: "content") as? String
                        
                        if let imageArray = tweetDic.object(forKey: "images") as? NSArray {
                            let array =  NSMutableArray()
                            for urlDic in imageArray {
                                let url: String = (urlDic as! NSDictionary).object(forKey: "url") as! String
                                array.add(url)
                            }
                            momentModel.imageArray = array.copy() as? NSArray
                        }
                        
                        if let senderDic: NSDictionary = tweetDic.object(forKey: "sender") as? NSDictionary {
                            let senderModel = TWMomentSenderModel()
                            senderModel.userName = senderDic["username"] as? String
                            senderModel.avatar = senderDic["avatar"] as? String
                            senderModel.nick = senderDic["nick"] as? String
                            momentModel.sender = senderModel
                        }
                        
                        if let commentArray:NSArray = tweetDic.object(forKey: "comments") as? NSArray {
                            let array = NSMutableArray()
                            for commentDic in commentArray {
                                let commentModel = TWMomentCommentModel()
                                
                                let content = (commentDic as! NSDictionary).object(forKey: "content") as? String
                                commentModel.content = content
                                
                                if let senderDic: NSDictionary = (commentDic as! NSDictionary).object(forKey: "sender") as? NSDictionary {
                                    let sender = TWMomentSenderModel()
                                    sender.avatar = senderDic.object(forKey: "avatar") as? String
                                    sender.nick = senderDic.object(forKey: "nick") as? String
                                    sender.userName = senderDic.object(forKey: "username") as? String
                                    commentModel.sender = sender
                                }
                                
                                array.add(commentModel)
                            }
                            momentModel.commentArray = array.copy() as? NSArray
                        }
                        
                        // 过滤不符合的数据
                        if ((momentModel.content != nil) || ((momentModel.imageArray?.count) != nil)) {
                            resultArray.add(momentModel)
                        }
                        
                    }
                }
            }
            completion(resultArray.copy() as! NSArray)
        }
    }
    
}

