//
//  MoreCommentButton.swift
//  IMxyb
//
//  Created by Elise on 16/4/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MoreCommentButton: UIView {

    @IBOutlet weak var moreButton: UIButton!
    
    
    weak var delegate:MoreCommentButtonDelegate?
    
    
    
    @IBAction func moreButtonClick(_ sender: UIButton) {
        delegate?.moreCommentButton(sender)
    }
    
    
    class func moreCommentButtonFromXib(_ frame:CGRect) -> MoreCommentButton {
        let view = Bundle.main.loadNibNamed("MoreCommentButton", owner: nil, options: nil)?.last as? MoreCommentButton
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
@objc protocol MoreCommentButtonDelegate {
    func moreCommentButton(_ sender:UIButton)
}
