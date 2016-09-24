//
//  SearchTextField.swift
//  IMxyb
//
//  Created by Elise on 16/5/9.
//  Copyright © 2016年 Elise. All rights reserved.
//  自定义的搜索框

import UIKit

class SearchTextField: UITextField {
    
    fileprivate var leftV: UIView!
    fileprivate var leftImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftImageView = UIImageView(image: UIImage(named: "search"))
        leftV = UIView(frame: CGRect(x: 5, y: 0, width: 10 * 2 + leftImageView.width, height: 30))
        leftImageView.frame.origin = CGPoint(x: 5, y: (leftV.height - leftImageView.height) * 0.5)
        leftV.addSubview(leftImageView)
        self.autocorrectionType = .no
        leftView = leftV
        leftViewMode = UITextFieldViewMode.always
        background = UIImage(named: "searchbox")
        placeholder = "手机号 昵称"
        
        clearButtonMode = UITextFieldViewMode.always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftView?.frame.origin.x = 10
        
    }
}
