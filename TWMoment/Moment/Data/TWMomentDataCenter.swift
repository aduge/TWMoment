//
//  TWMomentDataCenter.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

typealias loadDataCompletionBlock = (_ momentList: NSMutableArray, _ userModel: TWMomentUserModel) -> ()

class TWMomentDataCenter: NSObject {
    private static var userModel: TWMomentUserModel?
    private static var momentList: NSMutableArray?
    
    private static var completion: loadDataCompletionBlock?
    
    class func preLoadData() {
        
        let workGroup: DispatchGroup = DispatchGroup()
        let workQueue: DispatchQueue = DispatchQueue.main
        
        workGroup.enter()
        TWMomentNetwork.getMomentArray { (momentArray:NSArray) in
            momentList = momentArray.mutableCopy() as? NSMutableArray
            workGroup.leave()
        }
        
        workGroup.enter()
        TWMomentNetwork.getUserInformation { (userInfo: TWMomentUserModel) in
            userModel = userInfo
            workGroup.leave()
        }
        
        workGroup.notify(queue: workQueue) {
            if (self.completion != nil) {
                 self.completion!(self.momentList!, self.userModel!)
            }
        }
    }
    
    class func loadData(completion: @escaping loadDataCompletionBlock) {
        self.completion = completion
        if (self.momentList != nil && self.userModel != nil) {
            self.completion!(self.momentList!, self.userModel!)
        }
    }
    
    class func reloadMomentArray(completion: @escaping (_ array: NSMutableArray) -> ()) {
        TWMomentNetwork.getMomentArray { (momentArray:NSArray) in
            momentList = momentArray.mutableCopy() as? NSMutableArray
            completion(momentList ?? [])
        }
    }
}
