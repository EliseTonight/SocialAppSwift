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
    private let leftButton:UIButton = UIButton()
    private let rightButton:UIButton = UIButton()
    private let middleButton:UIButton = UIButton()
    
    
    private let textFont = UIFont.systemFontOfSize(16)
    private let textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    
    private let bottomLineView = UIView()
    private var selectedButton: UIButton?
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
        leftButton.frame = CGRectMake(0, 0, self.frame.width / 3, self.frame.height)
        middleButton.frame = CGRectMake( self.frame.width / 3, 0,  self.frame.width / 3, self.frame.height)
        rightButton.frame = CGRectMake((self.frame.width / 3) * 2, 0, self.frame.width / 3, self.frame.height)
        bottomLineView.frame =  CGRectMake(0, self.frame.height - 2, self.frame.width / 3, 2)
    }
    
    
    
    
    private func setButton(button:UIButton,title:String,tag:Int) {
        button.setTitle(title, forState: .Normal)
        button.highlighted = false
        button.tag = tag
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(18)
        self.addSubview(button)
    }
    
    private func setBottomLine() {
        bottomLineView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        self.addSubview(bottomLineView)
    }
    
    
    @objc private func buttonClick(button:UIButton) {
        selectedButton?.selected = false
        button.selected = true
        selectedButton = button
        bottomViewAnimation((selectedButton?.tag)! - 1)
        delegate?.tableSwitchView(self, didSelectedButton: selectedButton!, forIndex: (selectedButton?.tag)! - 1)
        
    }
    
    private func bottomViewAnimation(index:Int) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
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
    func clickButtonWithIndex(index:Int) {
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
    
    func tableSwitchView(tableSwitchView:TableSwitchView, didSelectedButton button: UIButton,forIndex index:Int)

}














