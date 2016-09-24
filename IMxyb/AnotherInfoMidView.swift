//
//  AnotherInfoMidView.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AnotherInfoMidView: UIView {
    @IBOutlet weak var signView: UIView! {
        didSet {
            signView.setViewTap("signViewClick")
        }
    }
    
    @IBOutlet weak var proView: UIView!{
        didSet {
            proView.setViewTap("proViewClick")
        }
    }
    
    @IBOutlet weak var academyView: UIView!{
        didSet {
            academyView.setViewTap("academyViewClick")
        }
    }
    
    @IBOutlet weak var enthuseView: UIView!{
        didSet {
            enthuseView.setViewTap("enthuseViewClick")
        }
    }
    
    @IBOutlet weak var signLabel: UILabel!
    
    @IBOutlet weak var proLabel: UILabel!
    
    @IBOutlet weak var academyLabel: UILabel!

    @IBOutlet weak var enthusView: UILabel!
    
    
    weak var delegate:AnotherInfoMidViewDelegate?
    
    
    @objc fileprivate func signViewClick() {
//        delegate?.signViewDelegate!()
    }
    @objc fileprivate func proViewClick() {
//        delegate?.proViewDelegate!()
    }

    @objc fileprivate func academyViewClick() {
//        delegate?.academyViewDelegate!()
    }

    @objc fileprivate func enthuseViewClick() {
//        delegate?.enthusViewDelegate!()
    }


    
    
    
    
    
    
    class func anotherInfoMidViewFromXib(_ frame:CGRect) -> AnotherInfoMidView {
        let view = Bundle.main.loadNibNamed("AnotherInfoMidView", owner: nil, options: nil)?.last as? AnotherInfoMidView
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
@objc protocol AnotherInfoMidViewDelegate {
    @objc optional func signViewDelegate()
    @objc optional func proViewDelegate()
    @objc optional func academyViewDelegate()
    @objc optional func enthusViewDelegate()
}
