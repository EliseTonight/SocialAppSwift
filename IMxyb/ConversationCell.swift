//
//  ConversationCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell ,MLEmojiLabelDelegate{
    
    
    
    
    var model:singleMessageModel? {
        didSet {
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //信息栏
    fileprivate lazy var emojiLabel:MLEmojiLabel? = {
        let emojiLabel = MLEmojiLabel(frame: CGRect.zero)
        emojiLabel.delegate = self
        emojiLabel.font = UIFont.systemFont(ofSize: 16)
        emojiLabel.numberOfLines = 0
        emojiLabel.textInsets = UIEdgeInsetsMake(0,0,0,0)
        emojiLabel.isAttributedContent = true
        return emojiLabel
        
    }()
    //头像
    fileprivate  var iconImage = CornerImageView()
    //包含信息的背景
    fileprivate var container = UIView()
    //信息栏背景图
    fileprivate var containerBackImage = UIImageView()
    //遮盖view
    fileprivate var maskImageView = UIImageView()
    
    fileprivate func setupView() {

        self.contentView.addSubview(iconImage)
        //包含的View
        self.contentView.addSubview(container)
        
        container.addSubview(emojiLabel!)
        //把背景插入最低处
        container.insertSubview(containerBackImage, at: 0)
        
        self.setupAutoHeight(withBottomView: container, bottomMargin: 0)
        
        containerBackImage.sd_layout().spaceToSuperView(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        
    }

    func setModel(_ model:singleMessageModel) {
        self.model = model
        self.emojiLabel?.text = model.message
        
        setMessageOriginWithModel(model)
        //布局文字
        container.layer.mask?.removeFromSuperlayer()
        containerBackImage.didFinishAutoLayoutBlock = nil
        emojiLabel?.sd_resetLayout()
        .leftSpaceToView(container,20)?
        .topSpaceToView(container,8)?
        .autoHeightRatio(0)
        
        emojiLabel?.setSingleLineAutoResizeWithMaxWidth(200)
        container.setupAutoWidth(withRightView: emojiLabel, rightMargin: 20)
        container.setupAutoHeight(withBottomView: emojiLabel, bottomMargin: 20)
    }
    
    func setMessageOriginWithModel(_ model:singleMessageModel) {
        //自己发的信息
        self.iconImage.cornerRadius = 20
        if model.type == 0 {
            //消息在右侧
            self.iconImage.image = UIImage(named: model.myicon)
            self.iconImage.sd_resetLayout()
            .rightSpaceToView(self.contentView,10)?
            .topSpaceToView(self.contentView,10)?
            .widthIs(40)?
            .heightIs(40)
            container.sd_resetLayout().topEqualToView(self.iconImage)?.rightSpaceToView(self.iconImage,10)
            
            containerBackImage.image = UIImage(named: "SenderTextNodeBkg")?.stretchableImage(withLeftCapWidth: 50, topCapHeight: 30)
        }
        else {
            // 收到的消息设置居左样式
            self.iconImage.image = UIImage(named: model.icon!)
            self.iconImage.sd_resetLayout()
            .leftSpaceToView(self.contentView,10)?
            .topSpaceToView(self.contentView,10)?
            .widthIs(40)?
            .heightIs(40)
            
            container.sd_resetLayout().topEqualToView(self.iconImage)?.leftSpaceToView(self.iconImage,10)
            
            containerBackImage.image = UIImage(named: "ReceiverTextNodeBkg")?.stretchableImage(withLeftCapWidth: 50, topCapHeight: 30)
        }
        maskImageView.image = containerBackImage.image
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
