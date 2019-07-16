//
//  TWMomentCellProtocol.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/15.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

protocol TWMomentCellProtocol {
    
    var cellClass: String {get}
    var cellIdentifier: String {get}
    var momentList: NSMutableArray? {get set}
    
    func tableView(tableView: UITableView, section: NSInteger) -> NSInteger
    func tableView(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell
    func tableView(tableView: UITableView, indexPath: NSIndexPath) -> CGFloat
}
