//
//  TWUtility.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import Foundation
import UIKit

class TWUtility: NSObject {
    
    class func getSingleSize(singleSize:CGSize) -> CGSize {
        let max_width = kSCREEN_WIDTH - 150
        let max_height = kSCREEN_WIDTH - 130
        let image_width = singleSize.width
        let image_height = singleSize.height
        
        var result_width: CGFloat
        var result_height: CGFloat
        if (image_height/image_width > 3.0) {
            result_height = max_height
            result_width = result_height/2
        }
        else  {
            result_width = max_width
            result_height = max_width*image_height/image_width
            if (result_height > max_height) {
                result_height = max_height
                result_width = max_height*image_width/image_height
            }
        }
        let result: CGSize = CGSize.init(width: result_width, height: result_height)
        return result
    }
}
