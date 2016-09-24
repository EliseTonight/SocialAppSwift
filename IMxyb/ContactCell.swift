//
//  ContactCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    
    let fixHeight:CGFloat = 50
    
    
    var model:ContactModel? {
        didSet {
            self.headImageView.image = UIImage(named: (model?.image)!)
            self.nameLabel.text = model!.name
        }
    }
    
    fileprivate var headImageView = UIImageView()
    fileprivate var nameLabel = UILabel()
    
    fileprivate func setupView() {
        self.contentView.sd_layout().spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0))
        self.frame.size.width = 375
        
        self.contentView.addSubview(headImageView)
        
        nameLabel.textColor = UIColor.darkGray
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(nameLabel)
        
        
        var margin:CGFloat = 8;
        
        
        headImageView.sd_layout()
            .leftSpaceToView(self.contentView, margin)?
            .widthIs(35)?
            .heightEqualToWidth()?
            .centerYEqualToView(self.contentView);
        
        nameLabel.sd_layout()
            .leftSpaceToView(headImageView, margin)?
            .centerYEqualToView(headImageView)?
            .rightSpaceToView(self.contentView, margin)?
            .heightIs(30);
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
