//
//  AnotherInfoBottomView.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AnotherInfoBottomView: UIView {
    
    var delegate:AnotherInfoBottomViewDelegate?
    
    @IBAction func sendMessageButtonClick(sender: UIButton) {
        delegate?.anotherInfoBottomViewButtonClick(sender)
    }

    class func AnotherInfoBottonViewFromXib(frame:CGRect) -> AnotherInfoBottomView {
        let view = NSBundle.mainBundle().loadNibNamed("AnotherInfoBottomView", owner: nil, options: nil).last as? AnotherInfoBottomView
        view?.frame = frame
        return view!
    }
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
protocol AnotherInfoBottomViewDelegate {
    func anotherInfoBottomViewButtonClick(sender:UIButton)
}
