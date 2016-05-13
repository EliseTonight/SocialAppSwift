//
//  SingleCommentView.swift
//  IMxyb
//
//  Created by Elise on 16/4/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SingleCommentView: UIView {
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBAction func commentButtonClick(sender: UIButton) {
    }
    
    var model:CommentModel? {
        didSet {
            self.headImage.sd_setImageWithURL(NSURL(string: (model?.head!)!)!, placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
            self.contentLabel.text = model?.text
        }
    }
    
    
    
    
    
    
    class func singleCommentView(frame:CGRect) -> SingleCommentView {
        let view = NSBundle.mainBundle().loadNibNamed("SingleCommentView", owner: nil, options: nil).last as? SingleCommentView
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
