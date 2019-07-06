//
//  TWMomentDataCenter.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

class TWMomentDataCenter: NSObject {
    static var userModel: TWMomentUserModel?
    static var momentList: NSMutableArray?
    
    class func loadData() {
        TWMomentNetwork.getMomentArray { (momentArray:NSArray) in
            momentList = momentArray.mutableCopy() as? NSMutableArray;
        }
        
        TWMomentNetwork.getUserInformation { (userInfo: TWMomentUserModel) in
            userModel = userInfo
        }
    }
}
