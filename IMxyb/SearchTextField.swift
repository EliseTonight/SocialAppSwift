//
//  SearchTextField.swift
//  IMxyb
//
//  Created by Elise on 16/5/9.
//  Copyright © 2016年 Elise. All rights reserved.
//  自定义的搜索框

import UIKit

class SearchTextField: UITextField {
    
    private var leftV: UIView!
    private var leftImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftImageView = UIImageView(image: UIImage(named: "search"))
        leftV = UIView(frame: CGRectMake(5, 0, 10 * 2 + leftImageView.width, 30))
        leftImageView.frame.origin = CGPointMake(5, (leftV.height - leftImageView.height) * 0.5)
        leftV.addSubview(leftImageView)
        self.autocorrectionType = .No
        leftView = leftV
        leftViewMode = UITextFieldViewMode.Always
        background = UIImage(named: "searchbox")
        placeholder = "手机号 昵称"
        
        clearButtonMode = UITextFieldViewMode.Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftView?.frame.origin.x = 10
        
    }
}
