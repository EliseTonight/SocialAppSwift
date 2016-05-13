//
//  CityCollectionReusableView.swift
//  LittleDay
//
//  Created by Elise on 16/3/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CityCollectionReusableView: UICollectionReusableView {
    var headLabel:UILabel = UILabel()
    var headTitle:String? {
        didSet {
            headLabel.text = headTitle
            headLabel.font = UIFont.systemFontOfSize(18)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headLabel.frame = self.bounds
    }
    
    
    
    
    
    private func setUI() {
        headLabel.textAlignment = .Center
        headLabel.textColor = UIColor.blackColor()
        headLabel.font = UIFont.systemFontOfSize(22)
        self.addSubview(headLabel)
        
    }
    
}
class CityCollectionFootResusableView:UICollectionReusableView {
    
    private var footLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footLabel = UILabel()
        footLabel?.text = "更多城市,敬请期待..."
        footLabel?.textAlignment = .Center
        footLabel?.textColor = UIColor.darkGrayColor()
        footLabel?.font = UIFont.systemFontOfSize(16)
        self.addSubview(footLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}



