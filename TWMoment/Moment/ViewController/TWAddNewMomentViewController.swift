//
//  TWAddNewMomentViewController.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/19.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

class TWAddNewMomentViewController: UIViewController {
    
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发布动态"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(publishMoment))
        
        loadViewFrame()
    }
    
    func loadViewFrame() {
        textView = UITextView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height/3))
        self.view.addSubview(textView);
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.white
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    @objc func publishMoment () {
        let moment: TWMomentModel = TWMomentModel()
        let sender: TWMomentSenderModel = TWMomentSenderModel()
        sender.userName = TWMomentDataCenter.userModel?.userName
        sender.avatar = TWMomentDataCenter.userModel?.avatar
        sender.nick =  TWMomentDataCenter.userModel?.nick
        moment.sender = sender
        moment.content = textView.text
        
        guard (moment.content != nil) else {
            return
        }
        
        // post请求，增加一条纪录
        let params: NSMutableDictionary = NSMutableDictionary()
        params.setObject(moment.content!, forKey: "content" as NSCopying)
        TWHttpNetwork.post(urlString: "http://localhost:8080/addMoment", params: params) { (data : Optional<Any>?) in
            
        }
            
            
        TWMomentDataCenter.momentList?.insert(moment, at: 0)
        TWMomentDataCenter.isPublishedNewMoment = true
        self.navigationController?.popViewController(animated: true)
    }
}
