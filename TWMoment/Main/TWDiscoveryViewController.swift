//
//  TWDiscoveryViewController.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

class TWDiscoveryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "discoverCell"
    
    var vcType: Int!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 240.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        
        if vcType == 2 {
            loadViewFrame()
        }
    }
    
    func loadViewFrame() {
        
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20.0))
        headview.backgroundColor = UIColor.clear
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        self.tableView.separatorInset = .zero
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = headview
        
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.white
        
        cell.imageView?.image = UIImage(named: "moment_refresh")
        cell.textLabel?.text = "朋友圈"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TWMomentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

