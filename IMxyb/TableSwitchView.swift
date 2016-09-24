//
//  TableSwitchView.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class TableSwitchView: UIView {

    //职业圈，校友圈，兴趣圈
    fileprivate let leftButton:UIButton = UIButton()
    fileprivate let rightButton:UIButton = UIButton()
    fileprivate let middleButton:UIButton = UIButton()
    
    
    fileprivate let textFont = UIFont.systemFont(ofSize: 16)
    fileprivate let textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    
    fileprivate let bottomLineView = UIView()
    fileprivate var selectedButton: UIButton?
    var delegate:TableSwitchViewDelegate?
    
    //便捷初始化
    convenience  init(leftText:String,middleText:String,rightText:String) {
        self.init()
        setButton(leftButton, title: leftText, tag: 1)
        setButton(middleButton, title: middleText, tag: 2)
        setButton(rightButton, title: rightText, tag: 3)
        setBottomLine()
        buttonClick(leftButton)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftButton.frame = CGRect(x: 0, y: 0, width: self.frame.width / 3, height: self.frame.height)
        middleButton.frame = CGRect( x: self.frame.width / 3, y: 0,  width: self.frame.width / 3, height: self.frame.height)
        rightButton.frame = CGRect(x: (self.frame.width / 3) * 2, y: 0, width: self.frame.width / 3, height: self.frame.height)
        bottomLineView.frame =  CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width / 3, height: 2)
    }
    
    
    
    
    fileprivate func setButton(_ button:UIButton,title:String,tag:Int) {
        button.setTitle(title, for: UIControlState())
        button.isHighlighted = false
        button.tag = tag
        button.setTitleColor(UIColor.darkGray, for: .selected)
        button.setTitleColor(UIColor.lightGray, for: UIControlState())
        button.addTarget(self, action: "buttonClick:", for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(button)
    }
    
    fileprivate func setBottomLine() {
        bottomLineView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        self.addSubview(bottomLineView)
    }
    
    
    @objc fileprivate func buttonClick(_ button:UIButton) {
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        bottomViewAnimation((selectedButton?.tag)! - 1)
        delegate?.tableSwitchView(self, didSelectedButton: selectedButton!, forIndex: (selectedButton?.tag)! - 1)
        
    }
    
    fileprivate func bottomViewAnimation(_ index:Int) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.bottomLineView.frame.origin.x = CGFloat(index) * (self.frame.width / 3)
            }, completion: nil)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    func clickButtonWithIndex(_ index:Int) {
        let clickButton:UIButton = (self.viewWithTag(index + 1) as? UIButton)!
        self.buttonClick(clickButton)
    }

    
    


    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}

protocol TableSwitchViewDelegate {
    
    func tableSwitchView(_ tableSwitchView:TableSwitchView, didSelectedButton button: UIButton,forIndex index:Int)

}














