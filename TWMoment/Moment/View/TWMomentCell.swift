//
//  TWMomentCell.swift
//  TWMoment
//
//  Created by Aduge on 2019/7/6.
//  Copyright © 2019 Aduge. All rights reserved.
//

import UIKit

@objc protocol TWMomentCellDelegate {
    // 查看全文/收起
    @objc optional func didSelectFullText(cell: TWMomentCell)
}

class TWMomentCell: UITableViewCell {
    // 头像
    var headImageView: UIImageView?
    // 名称
    var nameLab: UILabel?
    // 全文
    var showAllBtn: UIButton?
    // 内容
    var linkLab: UILabel?
    // 图片
    var imageListView: TWImageListView!
    // 赞和评论视图
    lazy var commentView: UIView = {
        
        return UIView()
    }()
    // 赞和评论视图背景
    var bgImageView: UIImageView!
    
    // 动态
    var moment: TWMomentModel! {
        
        didSet {
            
            headImageView?.setWebImage(url: moment?.sender?.avatar as NSString?, defaultImage: nil, isCache: true)
            nameLab?.text = moment.sender?.userName
            
            // 正文
            showAllBtn?.isHidden = true
            linkLab?.isHidden = true
            var bottom = (nameLab?.bottom)! + CGFloat(kPaddingValue)
            var rowHeight:CGFloat = 0.0
            
            if moment.content?.count != 0 {
                
                linkLab?.isHidden = false
                linkLab?.text = moment.content
                
                var attrStrSize: CGSize = (linkLab?.sizeThatFits(CGSize.init(width: kTextWidth, height: kScreenHeight)))!
                attrStrSize.width = fmin(attrStrSize.width, kTextWidth);
                
                var labH: CGFloat = (attrStrSize.height)
                
                if labH > maxLimitHeight {
                    
                    if moment.isFullText != true {
                        
                        labH = maxLimitHeight
                        self.showAllBtn?.setTitle("全文", for: .normal)
                    }
                    else {
                        self.showAllBtn?.setTitle("收起", for: .normal)
                    }
                    showAllBtn?.isHidden = false
                }
                linkLab?.frame = CGRect(x: (nameLab?.left)!, y: bottom, width: (attrStrSize.width), height: labH)
                showAllBtn?.frame = CGRect(x: (nameLab?.left)!, y: (linkLab?.bottom)! + CGFloat(kArrowHeight), width: CGFloat(kMoreLabWidth), height: CGFloat(kMoreLabHeight))
                
                if (showAllBtn?.isHidden)! {
                    
                    bottom = (linkLab?.bottom)! + CGFloat(kPaddingValue)
                }
                else {
                    bottom = (showAllBtn?.bottom)! + CGFloat(kPaddingValue)
                }
            }
            
            // 图片
            imageListView.moment = moment
            if moment.imageArray?.count ?? 0 > 0 {
                
                imageListView.origin = CGPoint(x: (nameLab?.left)!, y: bottom)
                bottom = imageListView.bottom + CGFloat(kPaddingValue)
            }
            
            // 处理评论
            self.commentView.frame = .zero
            bgImageView.frame = .zero
            bgImageView.image = nil
            let _ = self.commentView.subviews.map {
                $0.removeFromSuperview()
            }
            
            // 处理赞
            var top: CGFloat = 0.0
            let width = kScreenWidth - CGFloat(kRightMargin) - (nameLab?.left)!
            
            // 处理评论
            let count = moment.commentArray?.count ?? 0
            if count > 0 {
                
                for i in 0..<count  {
                    let lab = CommentLabel(frame: CGRect(x: 0.0, y: top, width: width, height: 0.0))
                    lab.comment = (moment.commentArray![i] as! TWMomentCommentModel)
                    self.commentView.addSubview(lab)
                    
                    //更新
                    top += lab.height
                }
            }
            
            // 更新UI
            if top > 0 {
                
                bgImageView.frame = CGRect(x: (nameLab?.left)!, y: bottom, width: width, height: top + CGFloat(kArrowHeight))
                bgImageView.image = UIImage(named: "comment_bg")?.stretchableImage(withLeftCapWidth: 40, topCapHeight: 30)
                self.commentView.frame = CGRect(x: (nameLab?.left)!, y: bottom + CGFloat(kArrowHeight), width: width, height: top)
                rowHeight = self.commentView.bottom + CGFloat(kBlnk)
            }
            else {
                rowHeight = bottom + CGFloat(kBlnk)
            }
            
            moment.rowHeight = rowHeight
        }
    }
    // 代理
    var delegate: TWMomentCellDelegate?
    // 最大高度限制
    var maxLimitHeight: CGFloat!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        // 解决复用导致图片加载异常的问题
        imageListView.removeFromSuperview()
        imageListView = nil
        imageListView = TWImageListView(frame: .zero)
        self.contentView.addSubview(imageListView)
        
        headImageView?.removeFromSuperview()
        headImageView = nil
        headImageView = UIImageView(frame: CGRect(x: 10, y: kBlnk, width: kFaceWidth, height: kFaceWidth))
        headImageView?.contentMode = .scaleAspectFill
        headImageView?.isUserInteractionEnabled = true
        headImageView?.layer.masksToBounds = true
        self.contentView.addSubview(headImageView!)
    }
    
    // 加载视图
    func addContentView() {
        
        // 头像视图
        headImageView = UIImageView(frame: CGRect(x: 10, y: kBlnk, width: kFaceWidth, height: kFaceWidth))
        headImageView?.contentMode = .scaleAspectFill
        headImageView?.isUserInteractionEnabled = true
        headImageView?.layer.masksToBounds = true
        self.contentView.addSubview(headImageView!)
        
        // 名字视图
        nameLab = UILabel(frame: CGRect(x: (headImageView?.right)! + 10, y: (headImageView?.top)!, width: CGFloat(kTextWidth), height: 20.0))
        nameLab?.font = UIFont.systemFont(ofSize: 17)
        nameLab?.textColor = UIColor(red: 0.28, green: 0.35, blue: 0.54, alpha: 1)
        nameLab?.backgroundColor = UIColor.clear
        self.contentView.addSubview(nameLab!)
        
        // 正文视图
        linkLab = UILabel()
        linkLab?.font = kTextFont
        linkLab?.lineBreakMode = .byWordWrapping
        linkLab?.textColor = UIColor.black
        linkLab?.font = UIFont.systemFont(ofSize: 14)
        linkLab?.numberOfLines = 0
        self.contentView.addSubview(linkLab!)
        
        // 查看“全文”按钮
        showAllBtn = UIButton(type: .custom)
        showAllBtn?.titleLabel?.font = kTextFont
        showAllBtn?.contentHorizontalAlignment = .left
        showAllBtn?.backgroundColor = UIColor.clear
        showAllBtn?.setTitle("全文", for: .normal)
        showAllBtn?.setTitleColor(UIColor(red: 0.28, green: 0.35, blue: 0.54, alpha: 1), for: .normal)
        showAllBtn?.addTarget(self, action: #selector(fullTextClicked(sender:)), for: .touchUpInside)
        self.contentView.addSubview(showAllBtn!)
        
        // 图片区
        imageListView = TWImageListView(frame: .zero)
        self.contentView.addSubview(imageListView)
        
        // 评论视图
        bgImageView = UIImageView()
        self.contentView.addSubview(bgImageView)
        self.contentView.addSubview(self.commentView)
        
        maxLimitHeight = (linkLab?.font.lineHeight)! * 6
    }
    
    // 查看全文/ 收起
    @objc func fullTextClicked(sender: UIButton) {
        
        showAllBtn?.titleLabel?.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
            {
                self.showAllBtn?.titleLabel?.backgroundColor = UIColor.clear
                if self.delegate != nil {
                    self.delegate?.didSelectFullText!(cell: self)
                }
        })
    }
}

// 评论
class CommentLabel: UIView {
    // 内容Label
    var linkLab: UILabel!
    // 评论
    var comment: TWMomentCommentModel! {
        
        didSet{
            
            let likeStr: String = (comment.sender?.userName! ?? "") + ":" + comment.content! as String
            linkLab.text = likeStr
            var attrStrSize: CGSize = (linkLab?.sizeThatFits(CGSize.init(width: kTextWidth, height: kScreenHeight)))!
            attrStrSize.width = fmin(attrStrSize.width, kTextWidth);
            
            linkLab.frame = CGRect(x: 5.0, y: 3.0, width: attrStrSize.width, height: attrStrSize.height)
            self.height = attrStrSize.height + 5
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载视图
    func addContentView() {
        linkLab = UILabel()
        linkLab.lineBreakMode = .byWordWrapping
        linkLab.textColor = UIColor.black
        linkLab.font = UIFont.systemFont(ofSize: 14)
        linkLab.numberOfLines = 0
        self.addSubview(linkLab)
    }
    
}

