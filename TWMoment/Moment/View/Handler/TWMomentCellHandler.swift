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
    
    init(momentList: NSMutableArray?, cellDelegate: TWMomentCellDelegate) {
        self.momentList = momentList
        self.cellDelegate = cellDelegate
    }
    
    func tableView(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TWMomentCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier as String, for: indexPath as IndexPath) as! TWMomentCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.moment = self.momentList?[indexPath.row] as? TWMomentModel
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
