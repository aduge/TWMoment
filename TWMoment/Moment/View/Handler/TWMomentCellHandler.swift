//
//  TWMomentCellHandler.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/15.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit


class TWMomentCellHandler: NSObject, TWMomentCellProtocol {
    
    var momentList: NSMutableArray?
    
    weak var cellDelegate: TWMomentCellDelegate?
    
    var cellClass: String = "TWMomentCell"
    
    var cellIdentifier: String = "momentCell"
    
    var userModel: TWMomentUserModel
    
    init(momentList: NSMutableArray?, cellDelegate: TWMomentCellDelegate, userModel: TWMomentUserModel) {
        self.momentList = momentList
        self.cellDelegate = cellDelegate
        self.userModel = userModel
    }
    
    func tableView(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TWMomentCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier as String, for: indexPath as IndexPath) as! TWMomentCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        let model: TWMomentModel = (self.momentList?[indexPath.row] as? TWMomentModel)!
        cell.isSendbySelf = model.sender?.userName == self.userModel.userName
        cell.moment = model
        cell.delegate = self.cellDelegate
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, indexPath: NSIndexPath) -> CGFloat {
        let moment: TWMomentModel = self.momentList?.object(at: indexPath.row) as! TWMomentModel
        return moment.rowHeight ?? 200
    }
    
    func tableView(tableView: UITableView, section: NSInteger) -> NSInteger {
        if (self.momentList != nil) {
            return self.momentList!.count
        }
        return 0
    }
    
    
}
