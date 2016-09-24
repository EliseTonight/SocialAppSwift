//
//  SearchButton.swift
//  IMxyb
//
//  Created by Elise on 16/5/9.
//  Copyright © 2016年 Elise. All rights reserved.
//  搜索控制器搜索按钮

import UIKit

class SearchButton: UIButton {
    
    init(frame: CGRect, target: AnyObject, action: Selector) {
        super.init(frame: frame)
        
        setTitle("搜索", for: UIControlState())
        setTitle("取消", for: .selected)
        titleLabel!.font = UIFont.systemFont(ofSize: 18)
        setTitleColor(UIColor.black, for: UIControlState())
        setTitleColor(UIColor.black, for: .selected)
        alpha = 0
        titleLabel!.textAlignment = .center
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
