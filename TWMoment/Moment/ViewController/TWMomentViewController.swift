//
//  TWMomentViewController.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

class TWMomentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TWMomentCellDelegate, UITextFieldDelegate {
    
    let cellIdentifer: NSString = "momentCell"
    
    var userModel: TWMomentUserModel!
    var momentList: NSMutableArray!
    var tableView: UITableView!
    var headerView: UIView!
    var coverImageView: UIImageView!
    var headImageView: UIImageView!
    
    var textField: UITextField!
    var totalKeybordHeight: CGFloat!
    var isDelete: Int!
    
    var selectIndexPath:IndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "好友动态"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moment_camera"), style: .plain, target: nil, action: nil)
        
        loadViewData()
        
        loadViewFrame()
    }
    
    // 加载视图
    func loadViewFrame() {
        
        self.isDelete = 0
        
        // 封面
        let imageView = UIImageView(frame: CGRect(x: 0, y: -kTopHeight, width: kScreenWidth, height: 270))
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        imageView.contentScaleFactor = UIScreen.main.scale
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.setWebImage(url: self.userModel?.profileImage as NSString?, defaultImage: nil, isCache: true)
        self.coverImageView = imageView
        
        
        // 用户头像
        let imageViewt = UIImageView(frame: CGRect(x: kScreenWidth - 85, y: self.coverImageView.bottom - 40, width: 75, height: 75))
        imageViewt.backgroundColor = UIColor.clear
        imageViewt.isUserInteractionEnabled = true
        imageViewt.contentMode = .scaleAspectFill
        imageViewt.setWebImage(url: self.userModel?.avatar as NSString?, defaultImage: nil, isCache: true)
        self.headImageView = imageViewt
        
        // 表头
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 270))
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        view.addSubview(coverImageView)
        view.addSubview(headImageView)
        self.headerView = view
        
        // 表格
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kTopHeight))
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tableView.separatorInset = .zero
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 0
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = self.headerView
        self.tableView.register(TWMomentCell.self, forCellReuseIdentifier: cellIdentifer as String)
        self.view.addSubview(self.tableView)
        
        // 评论视图
        self.textField = UITextField()
        textField.returnKeyType = .done
        textField.delegate = self
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        textField.layer.borderWidth = 1
        textField.keyboardAppearance = .default
        
        if  textField.isFirstResponder {
            
            textField.resignFirstResponder()
            textField.becomeFirstResponder()
        }
        
        textField.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 40)
        UIApplication.shared.keyWindow?.addSubview(textField)
        
        textField.becomeFirstResponder()
        textField.resignFirstResponder()
    }
    
    // 加载数据
    func loadViewData() {
        self.momentList = TWMomentDataCenter.momentList
        self.userModel = TWMomentDataCenter.userModel
    }
    
    //MARK： Table cell delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.momentList != nil) {
            return self.momentList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TWMomentCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer as String, for: indexPath) as! TWMomentCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.moment = self.momentList[indexPath.row] as? TWMomentModel
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let moment: TWMomentModel = self.momentList.object(at: indexPath.row) as! TWMomentModel
        return moment.rowHeight ?? 200
    }

    
    // 查看全文、 收起
    func didSelectFullText(cell: TWMomentCell) {
        
        print("全文、收起")
        
        let indexPath = self.tableView.indexPath(for: cell)
        
        let moment:TWMomentModel = (self.momentList[indexPath!.row] as? TWMomentModel)!
        moment.isFullText = !(moment.isFullText ?? false)
        
        self.momentList.replaceObject(at: (indexPath?.row)!, with: moment)
        
        self.tableView.reloadRows(at: [indexPath!], with: .none)
    }
    
}

