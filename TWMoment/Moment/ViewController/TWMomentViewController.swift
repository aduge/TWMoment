//
//  TWMomentViewController.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

class TWMomentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TWMomentCellDelegate, UITextFieldDelegate {
    
    var userModel: TWMomentUserModel!
    var tableView: UITableView!
    var headerView: UIView!
    var coverImageView: UIImageView!
    var headImageView: UIImageView!
    var refreshControl: UIRefreshControl!
    
    var handlerList: Array<TWMomentCellProtocol>!
    var cellHandler: TWMomentCellProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "好友动态"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moment_camera"), style: .plain, target: nil, action: nil)
        
        loadViewDataAndFrame()
    }
    
    // 加载视图
    func loadViewFrame() {
        
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
        self.tableView.register(TWMomentCell.self, forCellReuseIdentifier: self.cellHandler.cellIdentifier as String)
        self.view.addSubview(self.tableView)
        
        //添加刷新
        refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "松手刷新新")
        self.tableView.addSubview(refreshControl)
    }
    
    // 加载数据
    func loadViewDataAndFrame() {
        TWMomentDataCenter.loadData { (momentList: NSMutableArray, userModel: TWMomentUserModel) in
            self.userModel = userModel
            
            // 数据装配
            self.cellHandler = TWMomentCellHandler.init(momentList: momentList, cellDelegate: self)
            if (self.cellHandler != nil) {
                self.handlerList = Array()
                self.handlerList.append(self.cellHandler!)
            }
            
            // 数据加载完成后再加载页面
            DispatchQueue.main.async {
                self.loadViewFrame()
            }
        }
    }
    
    //MARK： TableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return handlerList.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionHanler: TWMomentCellProtocol = self.handlerList[section]
        return sectionHanler.tableView(tableView:tableView, section:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionHanler: TWMomentCellProtocol = self.handlerList[indexPath.section]
        return sectionHanler.tableView(tableView: tableView, indexPath: indexPath as NSIndexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionHanler: TWMomentCellProtocol = self.handlerList[indexPath.section]
        return sectionHanler.tableView(tableView: tableView, indexPath: indexPath as NSIndexPath)
    }

    
    // 查看全文、 收起
    func didSelectFullText(cell: TWMomentCell) {
        
        print("全文、收起")
        
        let indexPath = self.tableView.indexPath(for: cell)
        
        let moment:TWMomentModel = (self.cellHandler.momentList![indexPath!.row] as? TWMomentModel)!
        moment.isFullText = !(moment.isFullText ?? false)
        
        self.cellHandler.momentList!.replaceObject(at: (indexPath?.row)!, with: moment)
        
        self.tableView.reloadRows(at: [indexPath!], with: .none)
    }
    
    //刷新
    @objc func refreshData() {
        TWMomentDataCenter.reloadMomentArray { (momentArray: NSMutableArray) in
            self.cellHandler.momentList = momentArray
            self.stopRefrest()
        }
    }
    
    @objc func stopRefrest(){
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
}

