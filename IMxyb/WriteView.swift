//
//  WriteView.swift
//  IMxyb
//
//  Created by Elise on 16/4/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class WriteView: UIView ,UITextFieldDelegate{
    @IBAction func textExit(_ sender: UITextField) {
        if sender.text ==  nil {
            
        }
        else {
            delegate?.writeViewShouldReturn(sender)
        }
    }
    
    var delegate:WriteViewDelegate?
    
    
    
    
    @IBAction func textEnd(_ sender: UITextField) {
        self.textFieldView.text = ""
        self.endEditing(true)
    }

    @IBOutlet weak var textFieldView: UITextField! {
        didSet {
            textFieldView.returnKeyType = .default
        
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === textFieldView {
            delegate?.writeViewShouldReturn(textFieldView)
            return true
        }
        else {
            return false
        }
    }

    

    
    
    
    
    class func writeViewFromXib(_ frame:CGRect) -> WriteView {
        let view = Bundle.main.loadNibNamed("WriteView", owner: nil, options: nil)?.last as? WriteView
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
protocol WriteViewDelegate {
    func writeViewShouldReturn(_ textField:UITextField)
}
