//
//  CommentCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    
    
    var model:CommentModel? {
        didSet {
            self.headImage.sd_setImageWithURL(NSURL(string: (model?.head)!), placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
            self.contentLabel.text = model?.text
        }
    }
    
    
    
    
    
    
    @IBAction func commentButtonClick(sender: UIButton) {
        
    }
    
    
    class func commentCellWithXib(tableView:UITableView) -> CommentCell? {
        let cellId = "commentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CommentCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CommentCell", owner: nil, options: nil).last as? CommentCell
        }
        return cell!
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
